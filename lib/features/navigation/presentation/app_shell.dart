import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/features/auth/controller/auth_session_controller.dart';
import 'package:zhu_app/features/auth/domain/auth_session_state.dart';
import 'package:zhu_app/features/component_workspace/component_workspace_page.dart';
import 'package:zhu_app/features/contacts/presentation/contacts_page.dart';
import 'package:zhu_app/features/notifications/notification_providers.dart';
import 'package:zhu_app/features/profile/presentation/profile_page.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authSessionControllerProvider);
    final email = switch (session) {
      AuthenticatedAuthSessionState(:final user) => user.email,
      _ => '',
    };

    return _AppNavigationScaffold(
      email: email,
      onSignOut: () => ref.read(sessionLogoutCoordinatorProvider).signOut(),
    );
  }
}

class _AppNavigationScaffold extends StatefulWidget {
  const _AppNavigationScaffold({required this.email, required this.onSignOut});

  final String email;
  final Future<void> Function() onSignOut;

  @override
  State<_AppNavigationScaffold> createState() => _AppNavigationScaffoldState();
}

class _AppNavigationScaffoldState extends State<_AppNavigationScaffold> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const ComponentWorkspacePage(),
          const ContactsPage(),
          ProfilePage(email: widget.email, onSignOut: widget.onSignOut),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Contacts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
