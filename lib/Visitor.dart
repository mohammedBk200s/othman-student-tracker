import 'package:flutter/material.dart';

class Visitor {
  final String name;
  final String phone;
  final String purpose;

  Visitor({required this.name, required this.phone, required this.purpose});

  // تحديد اللون بناءً على نوع الزيارة
  Color getPurposeColor() {
    switch (purpose) {
      case 'استشارة': return Colors.blue;
      case 'تسجيل دورة': return Colors.green;
      case 'صيانة': return Colors.orange;
      default: return Colors.grey;
    }
  }
}