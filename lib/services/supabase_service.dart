import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  //สร้าง Object/Instance/ตัวแทน ที่จะใช้ทำงานต่างๆ กับ Supabase
  final supabase = Supabase.instance.client;

  //ส่วนของเมธอดการทำงานต่างๆ กับ Supabase
  //เช่น การเพิ่ม..., การแก้ไข..., การลบ...., การค้นหา-ตรวจสอบ-ดึง-ดู....

  //สร้างเมธอดสำหรับการดึงข้อมูลทั้งหมดจาก run_tb ใน Supabase
  Future<List<Run>> getAllRun() async {
    //ดึงข้อมูลทั้งหมดจาก run_tb ใน Supabase
    final data = await supabase.from('run_tb').select('*');

    //แปลงข้อมูลที่ได้จาก Supabase ซึ่งเป็น JSON มาใช้ในแอปฯ แล้วส่งผลกลับไป ณ จุดเรียกใช้เมธอด
    return data.map<Run>((e) => Run.fromJson(e)).toList();
  }

  //สร้างเมธอดเพิ่มข้อมูลเข้าไปใน run_tb ใน Supabase
  Future insertRun(Run run) async {
    await supabase.from('run_tb').insert(run.toJson());
  }

  //สร้างเมธอดแก้ไขข้อมูลใน run_tb ใน Supabase
  Future updateRun(String id, Run run) async {
    await supabase.from('run_tb').update(run.toJson()).eq('id', id);
  }

  //สร้างเมธอดลบข้อมูลใน run_tb ใน Supabase
  Future deleteRun(String id) async {
    await supabase.from('run_tb').delete().eq('id', id);
  }
}
