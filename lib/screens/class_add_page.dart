// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/scroll_glow.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';

class ClassAddPage extends StatefulWidget {
  final int classId;

  const ClassAddPage({Key? key, this.classId = 0}) : super(key: key);

  @override
  _ClassAddPageState createState() => _ClassAddPageState();
}

class _ClassAddPageState extends State<ClassAddPage> {
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
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: SigavCircleIcon(
                            action: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black26,
                            ),
                          )),
                    ],
                  ),
                  Text(widget.classId == 0 ? "Criar turma" : "Editar turma",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 16.0),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: "Nome",
                              hintStyle: TextStyle(color: Colors.black26),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black26)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: "Descrição",
                              hintStyle: TextStyle(color: Colors.black26),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black26)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide:
                                      BorderSide(color: Colors.black38))),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: [
                            CupertinoSwitch(
                              value: true,
                              activeColor: Colors.blue.shade400,
                              onChanged: (bool value) {},
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text("Turma aberta",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black54)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: SigavButton(
                            title: widget.classId == 0 ? "Criar" : "Editar",
                            action: () {
                              Navigator.pop(context);
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: widget.classId == 0
                              ? null
                              : SigavButton(
                                  red: true,
                                  title: "Remover",
                                  action: () {
                                    Navigator.pop(context);
                                  },
                                ))
                    ],
                  ))
                ],
              ))),
    );
  }
}
