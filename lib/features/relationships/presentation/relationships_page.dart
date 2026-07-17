import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';
import 'package:zhu_app/features/relationships/controller/relationships_controller.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/domain/relationship_models.dart';

class RelationshipsPage extends ConsumerStatefulWidget {
  const RelationshipsPage({super.key, required this.kind});

  final RelationshipKind kind;

  @override
  ConsumerState<RelationshipsPage> createState() => _RelationshipsPageState();
}

class _RelationshipsPageState extends ConsumerState<RelationshipsPage> {
  final _phoneController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  String? _phoneError;

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(relationshipsControllerProvider(widget.kind));
    final controller = ref.read(
      relationshipsControllerProvider(widget.kind).notifier,
    );

    return SafeArea(
      child: switch (state) {
        AsyncData(:final value) => RefreshIndicator(
          onRefresh: controller.refresh,
          child: _RelationshipsContent(
            kind: widget.kind,
            data: value,
            phoneController: _phoneController,
            phoneFocusNode: _phoneFocusNode,
            phoneError: _phoneError,
            onPhoneChanged: () {
              if (_phoneError != null) setState(() => _phoneError = null);
            },
            onRefresh: controller.refresh,
            onAddRequest: _addRequest,
            onAccept: (id) => _perform(
              () => controller.accept(id),
              successMessage: 'Request accepted.',
            ),
            onDecline: (id) => _perform(
              () => controller.decline(id),
              successMessage: 'Request declined.',
            ),
            onRemove: (user) => _confirmRemoval(user, controller),
          ),
        ),
        AsyncError() => _RelationshipsError(onRetry: controller.refresh),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }

  Future<void> _addRequest() async {
    final phoneNumber = _phoneController.text.trim();
    if (!RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(phoneNumber)) {
      setState(() => _phoneError = 'Enter a valid E.164 phone number.');
      _phoneFocusNode.requestFocus();
      return;
    }

    final sent = await _perform(
      () => ref
          .read(relationshipsControllerProvider(widget.kind).notifier)
          .addRequest(phoneNumber),
      successMessage: 'Request sent.',
    );
    if (sent && mounted) _phoneController.clear();
  }

  Future<void> _confirmRemoval(
    RelationshipUser user,
    RelationshipsController controller,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove ${widget.kind.singularTitle}?'),
        content: Text(
          'This will remove or cancel the relationship with ${_displayName(user)}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await _perform(
      () => controller.remove(user.id),
      successMessage: 'Relationship removed.',
    );
  }

  Future<bool> _perform(
    Future<void> Function() action, {
    required String successMessage,
  }) async {
    try {
      await action();
      if (!mounted) return true;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
      return true;
    } catch (_) {
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to update relationships. Try again.'),
        ),
      );
      return false;
    }
  }
}

class _RelationshipsContent extends StatelessWidget {
  const _RelationshipsContent({
    required this.kind,
    required this.data,
    required this.phoneController,
    required this.phoneFocusNode,
    required this.phoneError,
    required this.onPhoneChanged,
    required this.onRefresh,
    required this.onAddRequest,
    required this.onAccept,
    required this.onDecline,
    required this.onRemove,
  });

  final RelationshipKind kind;
  final RelationshipData data;
  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final String? phoneError;
  final VoidCallback onPhoneChanged;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onAddRequest;
  final Future<void> Function(String counterpartId) onAccept;
  final Future<void> Function(String counterpartId) onDecline;
  final Future<void> Function(RelationshipUser user) onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final incoming = data.requests
        .where((request) => request.requestedByRole != kind.currentUserRole)
        .toList(growable: false);
    final outgoing = data.requests
        .where((request) => request.requestedByRole == kind.currentUserRole)
        .toList(growable: false);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.screen.copyWith(
        top: AppSpacing.lg,
        bottom: AppSpacing.xxl,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                kind.path.toUpperCase(),
                style: theme.textTheme.technical,
              ),
            ),
            Semantics(
              button: true,
              label: 'Refresh ${kind.title.toLowerCase()}',
              child: IconButton(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(kind.title, style: theme.textTheme.h1),
        const SizedBox(height: AppSpacing.sm),
        Text(
          kind == RelationshipKind.guardians
              ? 'People who can help keep you safe.'
              : 'People you help keep safe.',
          style: theme.textTheme.muted,
        ),
        const SizedBox(height: AppSpacing.xl),
        _AddRequestCard(
          kind: kind,
          controller: phoneController,
          focusNode: phoneFocusNode,
          error: phoneError,
          onChanged: onPhoneChanged,
          onSubmit: onAddRequest,
        ),
        if (incoming.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(title: 'Incoming requests'),
          const SizedBox(height: AppSpacing.sm),
          for (final request in incoming) ...[
            _RequestCard(
              request: request,
              incoming: request.isPending,
              onAccept: request.isPending
                  ? () => onAccept(request.counterpart.id)
                  : null,
              onDecline: request.isPending
                  ? () => onDecline(request.counterpart.id)
                  : null,
              onCancel: request.isPending
                  ? null
                  : () => onRemove(request.counterpart),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
        if (outgoing.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xl),
          _SectionTitle(title: 'Outgoing requests'),
          const SizedBox(height: AppSpacing.sm),
          for (final request in outgoing) ...[
            _RequestCard(
              request: request,
              incoming: false,
              onAccept: null,
              onDecline: null,
              onCancel: () => onRemove(request.counterpart),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
        const SizedBox(height: AppSpacing.xl),
        if (kind == RelationshipKind.guardees &&
            _needsAttention(data.accepted).isNotEmpty) ...[
          const _SectionTitle(title: 'Needs attention'),
          const SizedBox(height: AppSpacing.sm),
          for (final user in _needsAttention(data.accepted)) ...[
            _AcceptedCard(
              user: user,
              kind: kind,
              onRemove: () => onRemove(user),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          const SizedBox(height: AppSpacing.md),
        ],
        _SectionTitle(
          title:
              kind == RelationshipKind.guardees &&
                  _needsAttention(data.accepted).isNotEmpty
              ? 'Other guardees'
              : 'Confirmed ${kind.title.toLowerCase()}',
        ),
        const SizedBox(height: AppSpacing.sm),
        if (data.accepted.isEmpty)
          _EmptyCard(kind: kind)
        else if (kind != RelationshipKind.guardees)
          for (final user in data.accepted) ...[
            _AcceptedCard(
              user: user,
              kind: kind,
              onRemove: () => onRemove(user),
            ),
            const SizedBox(height: AppSpacing.sm),
          ]
        else
          for (final user in _otherGuardees(data.accepted)) ...[
            _AcceptedCard(
              user: user,
              kind: kind,
              onRemove: () => onRemove(user),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _AddRequestCard extends StatelessWidget {
  const _AddRequestCard({
    required this.kind,
    required this.controller,
    required this.focusNode,
    required this.error,
    required this.onChanged,
    required this.onSubmit,
  });

  final RelationshipKind kind;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? error;
  final VoidCallback onChanged;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      title: Text('Add ${kind.singularTitle}', style: theme.textTheme.h4),
      description: Text('Send an invitation using their E.164 phone number.'),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ShadInput(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.telephoneNumber],
              placeholder: const Text('+628123456789'),
              onChanged: (_) => onChanged(),
              onSubmitted: (_) => onSubmit(),
            ),
            if (error != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                error!,
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.destructive,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            ShadButton(onPressed: onSubmit, child: const Text('Send request')),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.request,
    required this.incoming,
    required this.onAccept,
    required this.onDecline,
    required this.onCancel,
  });

  final RelationshipRequest request;
  final bool incoming;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _UserSummary(user: request.counterpart),
          const SizedBox(height: AppSpacing.md),
          Text(
            request.isDeclined
                ? incoming
                      ? 'Request declined'
                      : 'Request was declined'
                : incoming
                ? 'Waiting for your response'
                : 'Request pending',
            style: theme.textTheme.small.copyWith(
              color: incoming
                  ? theme.colorScheme.warning
                  : theme.colorScheme.mutedForeground,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              if (onAccept != null)
                ShadButton(onPressed: onAccept, child: const Text('Accept')),
              if (onDecline != null)
                ShadButton.outline(
                  onPressed: onDecline,
                  child: const Text('Decline'),
                ),
              if (onCancel != null)
                ShadButton.outline(
                  onPressed: onCancel,
                  child: Text(
                    request.isDeclined ? 'Dismiss' : 'Cancel request',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcceptedCard extends StatelessWidget {
  const _AcceptedCard({
    required this.user,
    required this.kind,
    required this.onRemove,
  });

  final RelationshipUser user;
  final RelationshipKind kind;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final canViewDetail = kind == RelationshipKind.guardees;
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (canViewDetail)
            InkWell(
              onTap: () => context.push('/guardees/${user.id}'),
              child: _UserSummary(user: user, trailing: Icons.chevron_right),
            )
          else
            _UserSummary(user: user),
          if (canViewDetail) ...[
            const SizedBox(height: AppSpacing.sm),
            _GuardeeStatusSummary(user: user),
          ],
          const SizedBox(height: AppSpacing.md),
          ShadButton.outline(
            onPressed: onRemove,
            child: Text('Remove ${kind.singularTitle}'),
          ),
        ],
      ),
    );
  }
}

class _GuardeeStatusSummary extends StatelessWidget {
  const _GuardeeStatusSummary({required this.user});

  final RelationshipUser user;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final status = user.safety?.status;
    final (label, color) = switch (status) {
      GuardeeSafetyStatus.needsHelp => (
        'NEEDS HELP',
        theme.colorScheme.destructive,
      ),
      GuardeeSafetyStatus.checkInOverdue => (
        'CHECK-IN OVERDUE',
        theme.colorScheme.warning,
      ),
      GuardeeSafetyStatus.atRisk => ('AT RISK', theme.colorScheme.warning),
      GuardeeSafetyStatus.protected => ('PROTECTED', theme.colorScheme.success),
      GuardeeSafetyStatus.ok || null => ('OK', theme.colorScheme.draftingBlue),
    };
    final updatedAt = user.location?.updatedAt;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: color.withValues(alpha: .12),
            borderRadius: const BorderRadius.all(AppRadius.small),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Text(
              label,
              style: theme.textTheme.technical.copyWith(color: color),
            ),
          ),
        ),
        if (updatedAt != null) ...[
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Location ${_locationAge(updatedAt)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.muted,
            ),
          ),
        ],
      ],
    );
  }
}

class _UserSummary extends StatelessWidget {
  const _UserSummary({required this.user, this.trailing});

  final RelationshipUser user;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: colors.primaryContainer,
          foregroundColor: colors.onPrimaryContainer,
          child: const Icon(Icons.person_outline),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_displayName(user), style: theme.textTheme.large),
              if (user.phoneNumber != null)
                Text(user.phoneNumber!, style: theme.textTheme.muted),
            ],
          ),
        ),
        if (trailing != null) Icon(trailing, color: colors.pencilGrey),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: ShadTheme.of(context).textTheme.h3);
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.kind});

  final RelationshipKind kind;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.people_outline,
            color: ShadTheme.of(context).colorScheme.pencilGrey,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No ${kind.title.toLowerCase()} yet',
                  style: theme.textTheme.large,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Send a request above to get started.',
                  style: theme.textTheme.muted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RelationshipsError extends StatelessWidget {
  const _RelationshipsError({required this.onRetry});

  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: AppSpacing.screen,
      child: Center(
        child: ShadCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Unable to load relationships', style: theme.textTheme.h3),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Check your connection and try again.',
                style: theme.textTheme.muted,
              ),
              const SizedBox(height: AppSpacing.md),
              ShadButton.outline(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<RelationshipUser> _needsAttention(List<RelationshipUser> users) {
  return users
      .where((user) {
        final status = user.safety?.status;
        return status == GuardeeSafetyStatus.needsHelp ||
            status == GuardeeSafetyStatus.checkInOverdue ||
            status == GuardeeSafetyStatus.atRisk;
      })
      .toList(growable: false)
    ..sort(_compareGuardeeUrgency);
}

List<RelationshipUser> _otherGuardees(List<RelationshipUser> users) {
  return users
      .where((user) {
        final status = user.safety?.status;
        return status != GuardeeSafetyStatus.needsHelp &&
            status != GuardeeSafetyStatus.checkInOverdue &&
            status != GuardeeSafetyStatus.atRisk;
      })
      .toList(growable: false)
    ..sort(_compareGuardeeUrgency);
}

int _compareGuardeeUrgency(RelationshipUser left, RelationshipUser right) {
  return _urgency(
    left.safety?.status,
  ).compareTo(_urgency(right.safety?.status));
}

int _urgency(GuardeeSafetyStatus? status) {
  return switch (status) {
    GuardeeSafetyStatus.needsHelp => 0,
    GuardeeSafetyStatus.checkInOverdue => 1,
    GuardeeSafetyStatus.atRisk => 2,
    GuardeeSafetyStatus.protected => 3,
    GuardeeSafetyStatus.ok || null => 4,
  };
}

String _locationAge(DateTime updatedAt) {
  final age = DateTime.now().difference(updatedAt.toLocal());
  if (age.isNegative || age < const Duration(minutes: 1)) return 'updated now';
  if (age < const Duration(hours: 1)) return '${age.inMinutes} min ago';
  if (age < const Duration(days: 1)) return '${age.inHours} hr ago';
  return '${age.inDays} d ago';
}

String _displayName(RelationshipUser user) {
  return user.displayName ?? user.email ?? user.phoneNumber ?? 'Unknown user';
}
