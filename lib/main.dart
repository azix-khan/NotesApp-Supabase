import 'package:flutter/material.dart';
import 'package:notes_supabase/Auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://knkejxajnyqkiakmqhiv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtua2VqeGFqbnlxa2lha21xaGl2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg2NTAxNTcsImV4cCI6MjA5NDIyNjE1N30.lCyK34lFjOkOEvBVhgjdR0icFVjzBv2YaQMHUs7O55E',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Notes App with supabase', home: AuthGate());
  }
}
