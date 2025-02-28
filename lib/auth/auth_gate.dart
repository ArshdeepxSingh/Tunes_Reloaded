import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tunes_reloaded/pages/home/home_page.dart';
import 'package:tunes_reloaded/pages/login/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      // Listen to authentication state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // Show loading indicator while waiting for the first event
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Extract session properly from AuthState
        final session = snapshot.data?.session;

        // Navigate accordingly based on authentication state
        return session != null ? const HomePage() :  LoginPage();
      },
    );
  }
}
