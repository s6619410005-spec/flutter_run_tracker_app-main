import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  //สร้างตัวเเปรเก็บข้อมูล ที่นำไปแสดงใน ListView
  List<Run> runs = [];

  //สร้าง instance ของ SupabaseService
  final service = SupabaseService();

  //สร้างเมธอดสําหรับดึงข้อมูลทั้งหมดจาก supabase ผ่านทาง SupabaseService
  void loadAllRun() async {
    //สร้าตัวเเปรเก็บข้อมู,ที่ดึงได้จากการดีงผ่าน supabaseservice
    final data = await service.getAllRun();
    setState(() {
      //เก็บข้อมูลที่ได้จากการดึงผ่านทาง supabase ไว้ในตัวเเปร foods เพื่อเอาไปใช้ body
      runs = data;
    });
  }

  @override
  void initState() {
    loadAllRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          'Run Tracker',
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            //ส่วนเเสดง LOGO
            Image.asset(
              '/images/running.png',
              width: 200,
              height: 180,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 20,
            ),
            //ส่วนเเสดงข้อมูลที่ดึงมาจาก Supabase
            Expanded(
                child: ListView.builder(
              itemCount: runs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 5.0, top: 5.0),
                  child: ListTile(
                    onTap: () {
                      //เมื่อกดที่ ListTile ให้ไปหน้า UpdateDeleteRunUi พร้อมส่งข้อมูลของ run ที่กดไปด้วย
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateDeleteRunUi(
                            run: runs[index],
                          ),
                        ),
                      ).then((value) {
                        //เมื่อกลับมาที่หน้านี้ให้โหลดข้อมูลใหม่อีกครั้ง เพื่อให้เห็นการเปลี่ยนแปลงที่เกิดขึ้น
                        loadAllRun();
                      });
                    },
                    leading: Image.asset(
                      '/images/logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    trailing: Icon(
                      Icons.info,
                      color: Colors.red,
                    ),
                    title: Text(
                      'วิ่งที่ไหน ${runs[index].runWhere}',
                    ),
                    subtitle: Text(
                      'ระยะทาง ${runs[index].runDistance} กม., วิ่งกับใคร: ${runs[index].runWho}',
                    ),
                    tileColor:
                        index % 2 == 0 ? Colors.orange[100] : Colors.grey[300],
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRunUi(),
            ),
          ).then((value) {
            loadAllRun();
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
        backgroundColor: Colors.orange[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
