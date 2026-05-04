import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_service.dart';
import 'package:google_fonts/google_fonts.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runWhoCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  //เมธอดบันทึกข้อมูลไปที่ Supabase
  void saveRun() async {
    if (runWhereCtrl.text.isEmpty ||
        runWhoCtrl.text.isEmpty ||
        runDistanceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณาป้อนข้อมูลให้ครบทุกช่อง'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    //เเพ็คข้อมูลส่งไปที่ Supabase
    Run run = Run(
        runWhere: runWhereCtrl.text,
        runWho: runWhoCtrl.text,
        runDistance: double.parse(runDistanceCtrl.text));

    // ส่งไปบันทึกที่ Supabase ผ่าน SupabaseService
    //สร้าง instance/object/ตัวแทน ของ SupabaseService
    final service = SupabaseService();
    await service.insertRun(run);

    // แจ้งผลการทํางานกับผู้ใช้
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกข้อมูลเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // กลับไปหน้า ShowAllFoodUi
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          'Run Tracker (เพิ่ม)',
          style: GoogleFonts.outfit(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 50),
        child: Center(
          child: Column(
            children: [
              //ส่วนเเสดง LOGO
              Image.asset(
                '/images/running.png',
                width: 200,
                height: 180,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'วิ่งที่ไหน',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runWhereCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น สวนสาธารณะ, สนามกีฬา หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'วิ่งกับใคร',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runWhoCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น สมชาย, สมหญิง หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 20),
              // ป้อนระยะทาง
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ระยะทาง',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                controller: runDistanceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: 'เช่น 1, 5, 11 หรือ อื่นๆ',
                ),
              ),
              SizedBox(height: 30),
              // ปุ่มบันทึก
              ElevatedButton(
                onPressed: () {
                  saveRun();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: Text(
                  "บันทึกข้อมูล",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    runWhereCtrl.clear();
                    runDistanceCtrl.clear();
                    runWhoCtrl.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width,
                    50,
                  ),
                ),
                child: Text(
                  "ยกเลิก",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
