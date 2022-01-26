// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/scroll_glow.dart';
import 'package:sigav_app/screens/class_add_page.dart';
import 'package:sigav_app/screens/meet_add_page.dart';
import 'package:sigav_app/screens/meet_detail_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';

class ClassDetailPage extends StatefulWidget {
  const ClassDetailPage({Key? key}) : super(key: key);

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
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
                              Icons.arrow_back,
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
                                      builder: (context) => ClassAddPage(
                                            classId: 1,
                                          )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black26,
                            ),
                          )),
                    ],
                  ),
                  Text("Turma",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Row(
                    children: [
                      Icon(
                        Icons.folder_shared,
                        color: Colors.black54,
                        size: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("DDM - Turma 1",
                            style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Encontros",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeetAddPage()));
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.add,
                              color: Colors.black38,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SigavCard(
                      title: "Qua, 26/01 - Aula 16",
                      action1: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeetAddPage(
                                      meetId: 1,
                                    )));
                      },
                      action2: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeetDetailPage()));
                      },
                      desc: "Apresentação dos projetos",
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black54,
                      )),
                  SigavCard(
                      title: "Seg, 31/01 - Aula 17",
                      action1: () {},
                      action2: () {},
                      desc: "Acompanhamento dos projetos",
                      icon: Icon(
                        Icons.bookmark,
                        color: Colors.black54,
                      )),
                ],
              ))),
    );
  }
}
