import 'package:chatt_app/firebase_options.dart';
import 'package:chatt_app/screens/navbar/bottom_navbar_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://gszbzcelioputgxiswrf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdzemJ6Y2VsaW9wdXRneGlzd3JmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM4ODY3NDcsImV4cCI6MjA3OTQ2Mjc0N30.s_4kditim96e-IR_j1ze8mY65OZi8IEkNz3uXffPGSA',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      home: BottomNavbarScreen(),
    );
  }
}
