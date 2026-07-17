import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:zhu_app/features/home/presentation/home_page.dart';
import 'package:zhu_app/features/notifications/notification_providers.dart';
import 'package:zhu_app/features/profile/presentation/profile_page.dart';
import 'package:zhu_app/features/relationships/domain/relationship_kind.dart';
import 'package:zhu_app/features/relationships/presentation/relationships_page.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _AppNavigationScaffold(
      selectedIndex: selectedIndex,
      onSignOut: () => ref.read(sessionLogoutCoordinatorProvider).signOut(),
    );
  }
}

class _AppNavigationScaffold extends StatefulWidget {
  const _AppNavigationScaffold({
    required this.selectedIndex,
    required this.onSignOut,
  });

  final int selectedIndex;
  final Future<void> Function() onSignOut;

  @override
  State<_AppNavigationScaffold> createState() => _AppNavigationScaffoldState();
}

class _AppNavigationScaffoldState extends State<_AppNavigationScaffold> {
  late int _selectedIndex;
  late final Set<int> _mountedTabs;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _mountedTabs = {widget.selectedIndex};
  }

  @override
  void didUpdateWidget(covariant _AppNavigationScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex == widget.selectedIndex) return;
    setState(() {
      _selectedIndex = widget.selectedIndex;
      _mountedTabs.add(widget.selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          if (_mountedTabs.contains(0))
            Offstage(offstage: _selectedIndex != 0, child: const HomePage()),
          if (_mountedTabs.contains(1))
            Offstage(
              offstage: _selectedIndex != 1,
              child: const RelationshipsPage(kind: RelationshipKind.guardians),
            ),
          if (_mountedTabs.contains(2))
            Offstage(
              offstage: _selectedIndex != 2,
              child: const RelationshipsPage(kind: RelationshipKind.guardees),
            ),
          if (_mountedTabs.contains(3))
            Offstage(
              offstage: _selectedIndex != 3,
              child: ProfilePage(onSignOut: widget.onSignOut),
            ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectDestination,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Guardians',
          ),
          NavigationDestination(
            icon: Icon(Icons.supervisor_account_outlined),
            selectedIcon: Icon(Icons.supervisor_account),
            label: 'Guardees',
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

  void _selectDestination(int index) {
    final route = switch (index) {
      0 => '/workspace',
      1 => '/guardians',
      2 => '/guardees',
      _ => '/profile',
    };
    final router = GoRouter.maybeOf(context);
    if (router != null) {
      context.go(route);
      return;
    }
    setState(() {
      _selectedIndex = index;
      _mountedTabs.add(index);
    });
  }
}
