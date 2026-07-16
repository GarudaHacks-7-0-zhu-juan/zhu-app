import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_colors.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/design_system/theme/app_shad_theme.dart';

class ComponentWorkspacePage extends StatefulWidget {
  const ComponentWorkspacePage({super.key});

  @override
  State<ComponentWorkspacePage> createState() => _ComponentWorkspacePageState();
}

class _ComponentWorkspacePageState extends State<ComponentWorkspacePage> {
  bool _showAnnotations = true;
  int _markerCount = 2;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screen.copyWith(
            top: AppSpacing.lg,
            bottom: AppSpacing.xxxl,
          ),
          children: [
            _WorkspaceHeader(),
            const SizedBox(height: AppSpacing.xl),
            _AssemblyCard(
              markerCount: _markerCount,
              showAnnotations: _showAnnotations,
              onAddMarker: () => setState(() => _markerCount++),
              onToggleAnnotations: (value) =>
                  setState(() => _showAnnotations = value),
            ),
            const SizedBox(height: AppSpacing.xxl),
            _SectionHeading(
              eyebrow: 'FOUNDATION',
              title: 'Component states',
              description: 'Core controls share one measured visual language.',
            ),
            const SizedBox(height: AppSpacing.md),
            _ControlsCard(),
            const SizedBox(height: AppSpacing.xxl),
            _SectionHeading(
              eyebrow: 'FEEDBACK',
              title: 'System states',
              description: 'Clear next steps without decorative noise.',
            ),
            const SizedBox(height: AppSpacing.md),
            _StatesCard(),
          ],
        ),
      ),
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('ZHU / UI LAB', style: theme.textTheme.technical),
            const Spacer(),
            Text('REV 1.0', style: theme.textTheme.technical),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Schematic workspace', style: theme.textTheme.h1),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'A working surface for architectural planning components.',
          style: theme.textTheme.p.copyWith(
            color: theme.colorScheme.mutedForeground,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _DimensionRule(label: 'MOBILE / LIGHT / 01'),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(eyebrow, style: theme.textTheme.technical),
        const SizedBox(height: AppSpacing.xs),
        Text(title, style: theme.textTheme.h3),
        const SizedBox(height: AppSpacing.xs),
        Text(description, style: theme.textTheme.muted),
      ],
    );
  }
}

class _DimensionRule extends StatelessWidget {
  const _DimensionRule({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Row(
      children: [
        SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.draftingBlue,
              borderRadius: const BorderRadius.all(AppRadius.small),
            ),
          ),
        ),
        Expanded(child: ShadSeparator.horizontal(color: colors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(label, style: ShadTheme.of(context).textTheme.technical),
        ),
        Expanded(child: ShadSeparator.horizontal(color: colors.divider)),
        SizedBox(
          width: 8,
          height: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.draftingBlue,
              borderRadius: const BorderRadius.all(AppRadius.small),
            ),
          ),
        ),
      ],
    );
  }
}

class _AssemblyCard extends StatelessWidget {
  const _AssemblyCard({
    required this.markerCount,
    required this.showAnnotations,
    required this.onAddMarker,
    required this.onToggleAnnotations,
  });

  final int markerCount;
  final bool showAnnotations;
  final VoidCallback onAddMarker;
  final ValueChanged<bool> onToggleAnnotations;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    final percent = 0.42;

    return ShadCard(
      title: Row(
        children: [
          Expanded(child: Text('Current assembly', style: theme.textTheme.h4)),
          ShadBadge.outline(
            child: Text('IN REVIEW', style: theme.textTheme.label),
          ),
        ],
      ),
      description: const Text('One meaningful schematic visualization.'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            label: 'Floor plan schematic with $markerCount markers',
            child: SizedBox(
              height: 176,
              child: CustomPaint(
                painter: _PlanPainter(
                  lineColor: colors.outlineStrong,
                  accentColor: colors.draftingBlue,
                  labelColor: colors.pencilGrey,
                  markerCount: markerCount,
                  showAnnotations: showAnnotations,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ASSEMBLY PROGRESS', style: theme.textTheme.technical),
              Text('03 / 08', style: theme.textTheme.technical),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Semantics(
            label: 'Assembly progress',
            value: '42 percent',
            child: ShadProgress(value: percent, semanticsValue: '42%'),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('42% complete', style: theme.textTheme.muted),
              Text('$markerCount markers placed', style: theme.textTheme.muted),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          ShadSeparator.horizontal(color: colors.divider),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ShadButton(
                onPressed: onAddMarker,
                child: const Text('Add marker'),
              ),
              ShadButton.outline(
                onPressed: () {},
                child: const Text('View details'),
              ),
              SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Annotations', style: theme.textTheme.small),
                    const SizedBox(width: AppSpacing.sm),
                    ShadSwitch(
                      value: showAnnotations,
                      onChanged: onToggleAnnotations,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ControlsCard extends StatelessWidget {
  const _ControlsCard();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Primary actions', style: theme.textTheme.large),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              ShadButton(onPressed: () {}, child: const Text('Primary')),
              ShadButton.secondary(
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              ShadButton.outline(
                onPressed: () {},
                child: const Text('Outline'),
              ),
              ShadButton.ghost(onPressed: () {}, child: const Text('Ghost')),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Persistent label', style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.sm),
          const ShadInput(placeholder: Text('Enter a location name')),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Visible labels remain in place while the field is focused.',
            style: theme.textTheme.muted,
          ),
        ],
      ),
    );
  }
}

class _StatesCard extends StatelessWidget {
  const _StatesCard();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StateRow(
            badge: ShadBadge(child: const Text('READY')),
            title: 'Plan synchronized',
            description: 'Latest revision is available offline.',
          ),
          const SizedBox(height: AppSpacing.lg),
          ShadSeparator.horizontal(color: colors.divider),
          const SizedBox(height: AppSpacing.lg),
          _StateRow(
            badge: ShadBadge.destructive(child: const Text('OFFLINE')),
            title: 'Connection interrupted',
            description: 'Local changes remain safe on this device.',
            action: ShadButton.outline(
              onPressed: () {},
              child: const Text('Retry connection'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ShadSeparator.horizontal(color: colors.divider),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.architecture, color: colors.pencilGrey, size: 24),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No saved locations', style: theme.textTheme.large),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Add a location to begin your first plan.',
                      style: theme.textTheme.muted,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ShadButton(
                      onPressed: () {},
                      child: const Text('Add location'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow({
    required this.badge,
    required this.title,
    required this.description,
    this.action,
  });

  final Widget badge;
  final String title;
  final String description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        badge,
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.large),
              const SizedBox(height: AppSpacing.xs),
              Text(description, style: theme.textTheme.muted),
              if (action != null) ...[
                const SizedBox(height: AppSpacing.md),
                action!,
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _PlanPainter extends CustomPainter {
  const _PlanPainter({
    required this.lineColor,
    required this.accentColor,
    required this.labelColor,
    required this.markerCount,
    required this.showAnnotations,
  });

  final Color lineColor;
  final Color accentColor;
  final Color labelColor;
  final int markerCount;
  final bool showAnnotations;

  @override
  void paint(Canvas canvas, Size size) {
    final structural = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final accent = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final marker = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final left = size.width * 0.12;
    final top = size.height * 0.16;
    final right = size.width * 0.88;
    final bottom = size.height * 0.82;
    final roomWidth = (right - left) * 0.58;
    final roomRight = left + roomWidth;
    final middle = top + (bottom - top) * 0.52;

    canvas.drawRect(Rect.fromLTRB(left, top, roomRight, bottom), structural);
    canvas.drawLine(
      Offset(roomRight, top),
      Offset(roomRight, middle - 15),
      structural,
    );
    canvas.drawLine(
      Offset(roomRight, middle + 15),
      Offset(roomRight, bottom),
      structural,
    );
    canvas.drawLine(
      Offset(left, middle),
      Offset(roomRight - 18, middle),
      structural,
    );
    canvas.drawRect(
      Rect.fromLTRB(roomRight, middle - 15, right, bottom),
      structural,
    );
    canvas.drawLine(
      Offset(roomRight, middle - 15),
      Offset(right, middle - 15),
      structural,
    );
    canvas.drawLine(
      Offset(right - 28, middle - 15),
      Offset(right - 28, middle + 15),
      accent,
    );

    final dimensionY = bottom + 20;
    canvas.drawLine(
      Offset(left, dimensionY),
      Offset(roomRight, dimensionY),
      structural,
    );
    canvas.drawLine(
      Offset(left, dimensionY - 5),
      Offset(left, dimensionY + 5),
      structural,
    );
    canvas.drawLine(
      Offset(roomRight, dimensionY - 5),
      Offset(roomRight, dimensionY + 5),
      structural,
    );

    if (showAnnotations) {
      final markerPositions = [
        Offset(left + roomWidth * 0.28, top + 25),
        Offset(left + roomWidth * 0.72, middle + 26),
        Offset(roomRight + (right - roomRight) * 0.48, bottom - 24),
      ];
      for (final position in markerPositions.take(markerCount)) {
        canvas.drawCircle(position, 4, marker);
        canvas.drawCircle(position, 8, accent);
      }
    }

    if (showAnnotations) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'GRID B-04     120 M',
          style: TextStyle(
            color: labelColor,
            fontFamily: 'IBMPlexMono',
            fontSize: 10,
            letterSpacing: 0.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(left, 0));
    }
  }

  @override
  bool shouldRepaint(covariant _PlanPainter oldDelegate) {
    return markerCount != oldDelegate.markerCount ||
        showAnnotations != oldDelegate.showAnnotations ||
        lineColor != oldDelegate.lineColor ||
        accentColor != oldDelegate.accentColor ||
        labelColor != oldDelegate.labelColor;
  }
}
