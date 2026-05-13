import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // SIGN IN
  Future<void> signInWithEmailPassword(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  // SIGN UP
  Future<void> signUpWithEmailPassword(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  // SIGN OUT
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // GET USER EMAIL
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;

    final user = session?.user;

    return user?.email;
  }
}
