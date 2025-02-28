import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tunes_reloaded/auth/auth_service.dart';
import 'package:tunes_reloaded/pages/get_started/page/get_started.dart';
import 'package:tunes_reloaded/pages/settings/settings_page.dart';

import 'package:tunes_reloaded/theme/app_colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  // Get auth service
  final authService = AuthService();

  // Logout button pressed
  void logout() async {
    await authService.signOut();
    if (context.mounted) {
      // Navigate back to GetStartedPage after logout
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const GetStartedPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDarkMode ? AppColors.darkgrey : AppColors.light,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Welcome!"),
            accountEmail: Text(user?.email ?? "No Email"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.dark : AppColors.primary,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: isDarkMode ? AppColors.light : AppColors.darkgrey),
            title: Text("Settings",
                style: TextStyle(
                    color: isDarkMode ? AppColors.light : AppColors.darkgrey)),
            onTap: () async {
              // First, close the drawer
              Navigator.maybePop(context);

              // Use Future.delayed to give the drawer closing action time to complete
              await Future.delayed(Duration(milliseconds: 200));

              // Check if the widget is still mounted
              if (mounted) {
                // Now perform the navigation to the Settings page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout,
                color: isDarkMode ? AppColors.light : AppColors.darkgrey),
            title: Text("Logout",
                style: TextStyle(
                    color: isDarkMode ? AppColors.light : AppColors.darkgrey)),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
