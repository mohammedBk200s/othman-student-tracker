import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Entry Form.dart';

void main() {
  runApp(VisitorRegistrationApp());
}

class VisitorRegistrationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'نظام تسجيل الزوار',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: EntryFormScreen(),
    );
  }
}