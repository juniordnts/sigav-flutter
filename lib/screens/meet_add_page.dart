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

class MeetAddPage extends StatefulWidget {
  final int meetId;

  const MeetAddPage({Key? key, this.meetId = 0}) : super(key: key);

  @override
  _MeetAddPageState createState() => _MeetAddPageState();
}

class _MeetAddPageState extends State<MeetAddPage> {
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
                  Text(
                      widget.meetId == 0 ? "Criar encontro" : "Editar encontro",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Row(
                    children: [
                      Icon(
                        Icons.folder_shared,
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("DDM - Turma 1",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                    ],
                  ),
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
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                              hintText: "Data",
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
                              hintText: "Link",
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
                          padding: EdgeInsets.only(top: 16.0),
                          child: SigavButton(
                            title: widget.meetId == 0 ? "Criar" : "Editar",
                            action: () {
                              Navigator.pop(context);
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: widget.meetId == 0
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