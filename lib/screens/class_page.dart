// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/scroll_glow.dart';
import 'package:sigav_app/screens/class_add_page.dart';
import 'package:sigav_app/screens/class_detail_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  List _todoList = [];

  Map<String, dynamic> _lastRemoved = Map();
  int _lastRemovedPos = 0;

  TextEditingController _titleController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   DatabaseHelper.retrieveDatabase().then((data) {
  //     setState(() {
  //       _todoList = json.decode(data);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: SigavCircleIcon(
                            action: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.black26,
                            ),
                          )),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: SigavCircleIcon(
                            action: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClassAddPage()));
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black26,
                            ),
                          )),
                    ],
                  ),
                  Text("Turmas",
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Text("Olá, professor Lucas",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        CupertinoSwitch(
                          value: true,
                          activeColor: Colors.blue.shade400,
                          onChanged: (bool value) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Mostrar turmas fechadas",
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        )
                      ],
                    ),
                  ),
                  SigavCard(
                      title: "DDM - Turma 1",
                      action1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassAddPage(
                                      classId: 1,
                                    )));
                      },
                      action2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClassDetailPage()));
                      },
                      desc: "Turma de desenvolvimento de sistemas mobile",
                      icon: Icon(
                        Icons.folder_shared,
                        color: Colors.black54,
                      )),
                  SigavCard(
                      active: false,
                      title: "DDM - Turma 2",
                      action1: () {},
                      action2: () {},
                      desc: "Turma de desenvolvimento de sistemas mobile",
                      icon: Icon(
                        Icons.folder_shared,
                        color: Colors.black54,
                      )),
                ],
              ))),
    );
  }
}
