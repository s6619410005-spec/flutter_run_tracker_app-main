//คลาสนี้ใช้สำหรับทำงานร่วมกับตารางในฐานข้อมูลที่จะทำงานด้วย

// ignore_for_file: non_constant_identifier_names
class Run {
  String? id; // รหัสของการวิ่ง (อาจจะเป็น UUID หรือรหัสเฉพาะ)
  String runWhere; // สถานที่วิ่ง
  String runWho; // ผู้วิ่งกับเรา
  double runDistance; // ระยะทางที่วิ่ง

  // กำหนดคอนสตรัคเตอร์สำหรับสร้างอ็อบเจ็กต์ Run
  Run({
    this.id,
    required this.runWhere,
    required this.runWho,
    required this.runDistance,
  });

  //แปลงข้อมูลที่รับมาจาก Supabase เพื่อมาใช้ในแอปฯ
  factory Run.fromJson(Map<String, dynamic> json) {
    return Run(
      id: json['id'],
      runWhere: json['runWhere'],
      runWho: json['runWho'],
      runDistance: (json['runDistance'] as num).toDouble(),
    );
  }

  //แปลงข้อมูลจากแอปฯ เพื่อส่งไปยัง Supabase
  Map<String, dynamic> toJson() {
    return {
      "runWhere": runWhere,
      "runWho": runWho,
      "runDistance": runDistance,
    };
  }
}
