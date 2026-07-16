import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/design_system/tokens/app_spacing.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/controller/auth_submission_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_failure.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';

enum AuthMode { signIn, register }

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key, required this.mode});

  final AuthMode mode;

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmationFocusNode = FocusNode();

  String? _emailError;
  String? _passwordError;
  String? _confirmationError;
  bool _obscurePassword = true;
  bool _obscureConfirmation = true;

  bool get _isRegistering => widget.mode == AuthMode.register;

  @override
  void initState() {
    super.initState();
    _emailController.text = ref.read(authDraftEmailProvider);
  }

  @override
  void didUpdateWidget(covariant AuthPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _passwordController.clear();
      _confirmationController.clear();
      setState(() {
        _passwordError = null;
        _confirmationError = null;
      });
      ref.read(authSubmissionControllerProvider.notifier).clearFailure();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmationFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final submission = ref.watch(authSubmissionControllerProvider);
    final session = ref.watch(authSessionControllerProvider);
    final isSubmitting = submission.isSubmitting;

    return PopScope(
      canPop: !_isRegistering,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _isRegistering) context.go('/login');
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: AppSpacing.screen.copyWith(
                top: AppSpacing.xxl,
                bottom: AppSpacing.xxl,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: AutofillGroup(
                  child: ShadCard(
                    title: Text(
                      _isRegistering ? 'Create your workspace' : 'Welcome back',
                      style: theme.textTheme.h2,
                    ),
                    description: Text(
                      _isRegistering
                          ? 'Create an account to access Zhu.'
                          : 'Sign in to access Zhu.',
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _SessionNotice(session: session),
                          _InputField(
                            label: 'Email',
                            error: _emailError,
                            input: ShadInput(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              enabled: !isSubmitting,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autofillHints: const [AutofillHints.email],
                              placeholder: const Text('you@example.com'),
                              onSubmitted: (_) =>
                                  _passwordFocusNode.requestFocus(),
                              onChanged: (value) {
                                ref
                                    .read(authDraftEmailProvider.notifier)
                                    .update(value);
                                _clearEmailError();
                              },
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _InputField(
                            label: 'Password',
                            error: _passwordError,
                            input: ShadInput(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              enabled: !isSubmitting,
                              obscureText: _obscurePassword,
                              autocorrect: false,
                              enableSuggestions: false,
                              textInputAction: _isRegistering
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              autofillHints: [
                                _isRegistering
                                    ? AutofillHints.newPassword
                                    : AutofillHints.password,
                              ],
                              placeholder: const Text('At least 8 characters'),
                              trailing: _PasswordVisibilityButton(
                                obscure: _obscurePassword,
                                enabled: !isSubmitting,
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                              onSubmitted: (_) => _isRegistering
                                  ? _confirmationFocusNode.requestFocus()
                                  : _submit(),
                              onChanged: (_) => _clearPasswordError(),
                            ),
                          ),
                          if (_isRegistering) ...[
                            const SizedBox(height: AppSpacing.md),
                            _InputField(
                              label: 'Confirm password',
                              error: _confirmationError,
                              input: ShadInput(
                                controller: _confirmationController,
                                focusNode: _confirmationFocusNode,
                                enabled: !isSubmitting,
                                obscureText: _obscureConfirmation,
                                autocorrect: false,
                                enableSuggestions: false,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.newPassword,
                                ],
                                placeholder: const Text('Repeat your password'),
                                trailing: _PasswordVisibilityButton(
                                  obscure: _obscureConfirmation,
                                  enabled: !isSubmitting,
                                  onPressed: () => setState(
                                    () => _obscureConfirmation =
                                        !_obscureConfirmation,
                                  ),
                                ),
                                onSubmitted: (_) => _submit(),
                                onChanged: (_) => _clearConfirmationError(),
                              ),
                            ),
                          ],
                          if (submission.failure case final failure?) ...[
                            const SizedBox(height: AppSpacing.md),
                            _FailureNotice(failure: failure),
                          ],
                          const SizedBox(height: AppSpacing.xl),
                          Semantics(
                            label: _isRegistering
                                ? 'Create account'
                                : 'Sign in',
                            child: ShadButton(
                              width: double.infinity,
                              onPressed: isSubmitting ? null : _submit,
                              child: isSubmitting
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      _isRegistering
                                          ? 'Create account'
                                          : 'Sign in',
                                    ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          ShadButton.ghost(
                            width: double.infinity,
                            onPressed: isSubmitting
                                ? null
                                : () => context.go(
                                    _isRegistering ? '/login' : '/register',
                                  ),
                            child: Text(
                              _isRegistering
                                  ? 'Already have an account? Sign in'
                                  : 'New to Zhu? Create account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final controller = ref.read(authSubmissionControllerProvider.notifier);
    if (_isRegistering) {
      controller.register(email: email, password: password);
    } else {
      controller.signIn(email: email, password: password);
    }
  }

  bool _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmation = _confirmationController.text;
    final emailError =
        email.isEmpty || !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)
        ? 'Enter a valid email address.'
        : null;
    final passwordError = password.length < 8
        ? 'Password must contain at least 8 characters.'
        : null;
    final confirmationError = _isRegistering && confirmation != password
        ? 'Passwords do not match.'
        : null;

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
      _confirmationError = confirmationError;
    });

    if (emailError != null) {
      _emailFocusNode.requestFocus();
      return false;
    }
    if (passwordError != null) {
      _passwordFocusNode.requestFocus();
      return false;
    }
    if (confirmationError != null) {
      _confirmationFocusNode.requestFocus();
      return false;
    }
    return true;
  }

  void _clearEmailError() {
    if (_emailError != null) setState(() => _emailError = null);
  }

  void _clearPasswordError() {
    if (_passwordError != null) setState(() => _passwordError = null);
  }

  void _clearConfirmationError() {
    if (_confirmationError != null) {
      setState(() => _confirmationError = null);
    }
  }
}

class _InputField extends StatelessWidget {
  const _InputField({required this.label, required this.input, this.error});

  final String label;
  final Widget input;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final colors = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.small),
        const SizedBox(height: AppSpacing.xs),
        input,
        if (error != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            error!,
            style: theme.textTheme.small.copyWith(color: colors.destructive),
          ),
        ],
      ],
    );
  }
}

class _PasswordVisibilityButton extends StatelessWidget {
  const _PasswordVisibilityButton({
    required this.obscure,
    required this.enabled,
    required this.onPressed,
  });

  final bool obscure;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: obscure ? 'Show password' : 'Hide password',
      child: ShadButton.ghost(
        width: 40,
        height: 40,
        padding: EdgeInsets.zero,
        onPressed: enabled ? onPressed : null,
        child: Icon(obscure ? Icons.visibility_off : Icons.visibility),
      ),
    );
  }
}

class _FailureNotice extends StatelessWidget {
  const _FailureNotice({required this.failure});

  final AuthFailure failure;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Text(
      switch (failure) {
        ValidationAuthFailure() => 'Check the highlighted fields.',
        InvalidCredentialsAuthFailure() => 'Invalid email or password.',
        EmailAlreadyRegisteredAuthFailure() => 'Email is already registered.',
        UnauthorizedSessionAuthFailure() =>
          'Your session has expired. Sign in again.',
        NetworkAuthFailure() => 'Unable to connect. Try again.',
        TimeoutAuthFailure() => 'Unable to connect. Try again.',
        UnexpectedAuthFailure() => 'Something went wrong. Try again.',
      },
      style: theme.textTheme.small.copyWith(
        color: theme.colorScheme.destructive,
      ),
    );
  }
}

class _SessionNotice extends ConsumerWidget {
  const _SessionNotice({required this.session});

  final AuthSessionState session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    final message = switch (session) {
      UnauthenticatedAuthSessionState(:final notice?) => notice,
      UnavailableAuthSessionState() => 'Unable to restore your session.',
      _ => null,
    };
    if (message == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.destructive,
            ),
          ),
          if (session is UnavailableAuthSessionState) ...[
            const SizedBox(height: AppSpacing.sm),
            ShadButton.outline(
              onPressed: () => ref
                  .read(authSessionControllerProvider.notifier)
                  .retryRestore(),
              child: const Text('Retry session'),
            ),
          ],
        ],
      ),
    );
  }
}
