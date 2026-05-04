import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/views/show_all_run_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ShowAllRunUi()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40), // ระยะห่างขอบล่าง
        child: Column(
          children: [
            // ส่วนบน: ใช้ Expanded เพื่อให้กินพื้นที่ที่เหลือทั้งหมด ดันส่วนล่างลงไป
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/running.png',
                      width: 200,
                      // เอา height และ fit ออกเพื่อไม่ให้รูปผิดสัดส่วน
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Run Tracker',
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            // ส่วนล่าง: เครดิต
            Column(
              children: [
                Text(
                  '© 2026 RUN TRACKER',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Created by Sutthida SAU TEAM',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
