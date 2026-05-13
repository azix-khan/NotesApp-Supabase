import 'package:flutter/material.dart';
import 'package:notes_supabase/Pages/Auth/login_page.dart';
import 'package:notes_supabase/Pages/Note/notes_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // loading
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data!.session;

        // logged in
        if (session != null) {
          return NotePage();
        }

        // not logged in
        return LoginPage();
      },
    );
  }
}
