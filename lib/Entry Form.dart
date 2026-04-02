import 'package:flutter/material.dart';
import 'package:othman_student_tracker/Visitor.dart';

import 'Display List.dart';

class EntryFormScreen extends StatefulWidget {
  @override
  _EntryFormScreenState createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Visitor> _visitorList = []; // القائمة التي ستخزن الزوار

  // وحدات التحكم بالنصوص
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedPurpose;
  final List<String> _purposes = ['استشارة', 'تسجيل دورة', 'صيانة', 'أخرى'];

  void _saveVisitor() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _visitorList.add(Visitor(
          name: _nameController.text,
          phone: _phoneController.text,
          purpose: _selectedPurpose!,
        ));
      });

      // تصفير الحقول
      _nameController.clear();
      _phoneController.clear();
      setState(() => _selectedPurpose = null);

      // الانتقال للشاشة الثانية
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayListScreen(
            visitors: _visitorList,
            onDelete: (index) {
              setState(() {
                _visitorList.removeAt(index);
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تسجيل الزوار")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "اسم الزائر"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "الحقل إجباري";
                  if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%$#@!]').hasMatch(value)) {
                    return "لا يسمح باستخدام الرموز";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "رقم الهاتف"),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) return "الحقل إجباري";
                  if (value.length != 10) return "يجب أن يكون 10 أرقام";
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) return "أرقام فقط";
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedPurpose,
                hint: Text("سبب الزيارة"),
                items: _purposes.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setState(() => _selectedPurpose = val),
                validator: (val) => val == null ? "يرجى اختيار السبب" : null,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveVisitor,
                child: Text("حفظ البيانات"),
              )
            ],
          ),
        ),
      ),
    );
  }
}