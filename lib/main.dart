import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //---------------ตั้งค่า การเชื่อมต่อกับ Supabase---------------
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://agsppgkjchrgknhsowla.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFnc3BwZ2tqY2hyZ2tuaHNvd2xhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc5MjA4MzgsImV4cCI6MjA5MzQ5NjgzOH0.8dQpbm2DZ-fUBr5oVKfMmR8zb91OwZkoEv8AIVLpcbQ',
  );
  //------------------------------------------------------------
  runApp(FlutterRunTrackerApp());
}

class FlutterRunTrackerApp extends StatefulWidget {
  const FlutterRunTrackerApp({super.key});

  @override
  State<FlutterRunTrackerApp> createState() => _FlutterRunTrackerAppState();
}

class _FlutterRunTrackerAppState extends State<FlutterRunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Run Tracker',
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme: GoogleFonts.promptTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
