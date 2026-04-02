import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Visitor.dart';

class DisplayListScreen extends StatefulWidget {
  final List<Visitor> visitors;
  final Function(int) onDelete;

  DisplayListScreen({required this.visitors, required this.onDelete});

  @override
  _DisplayListScreenState createState() => _DisplayListScreenState();
}

class _DisplayListScreenState extends State<DisplayListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("قائمة الزوار")),
      body: widget.visitors.isEmpty
          ? Center(child: Text("لا يوجد زوار مسجلين"))
          : ListView.builder(
        itemCount: widget.visitors.length,
        itemBuilder: (context, index) {
          final visitor = widget.visitors[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: visitor.getPurposeColor(),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(visitor.name),
              subtitle: Text("${visitor.phone} - ${visitor.purpose}"),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    widget.onDelete(index);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}