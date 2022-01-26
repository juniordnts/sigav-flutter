// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/scroll_glow.dart';
import 'package:sigav_app/screens/class_add_page.dart';
import 'package:sigav_app/screens/meet_add_page.dart';
import 'package:sigav_app/widgets/sigav_actions.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';

class MeetDetailPage extends StatefulWidget {
  const MeetDetailPage({Key? key}) : super(key: key);

  @override
  _MeetDetailPageState createState() => _MeetDetailPageState();
}

class _MeetDetailPageState extends State<MeetDetailPage> {
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
          child: Stack(
        children: [
          Container(
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
                                      builder: (context) => MeetAddPage(
                                            meetId: 1,
                                          )));
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black26,
                            ),
                          )),
                    ],
                  ),
                  Text("Encontro",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark,
                        color: Colors.black54,
                        size: 32,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Qua, 26/01 - Aula 16",
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
                        Text("Ações",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                        Spacer(),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => MeetAddPage()));
                        //   },
                        //   child: Container(
                        //     width: 40,
                        //     height: 40,
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.black38),
                        //         borderRadius: BorderRadius.circular(20)),
                        //     child: Icon(
                        //       Icons.add,
                        //       color: Colors.black38,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 10.0,
                          children: [
                            SigavCircleIcon(
                              blue: true,
                              action: () {
                                _onButtonPressed("presence");
                              },
                              icon: Icon(
                                Icons.lock_open,
                                color: Colors.white,
                              ),
                            ),
                            SigavCircleIcon(
                              blue: true,
                              action: () {
                                _onButtonPressed("presence-list");
                              },
                              icon: Icon(
                                Icons.format_list_numbered,
                                color: Colors.white,
                              ),
                            ),
                            SigavCircleIcon(
                              blue: true,
                              action: () {
                                _onButtonPressed("question-list");
                              },
                              icon: Icon(
                                Icons.ballot,
                                color: Colors.white,
                              ),
                            ),
                            SigavCircleIcon(
                              blue: true,
                              action: () {
                                _onButtonPressed("question");
                              },
                              icon: Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ),
                            SigavCircleIcon(
                              blue: true,
                              action: () {
                                _onButtonPressed("note");
                              },
                              icon: Icon(
                                Icons.note,
                                color: Colors.white,
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text("Linha do tempo",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  ),
                  SigavCardAction(
                    type: "note",
                    title: "Nota de aula",
                    desc:
                        "Apresentaram os grupos 1, 2, 3, 12, 15 e 17. O restante vai apresentar na próxima aula.",
                  ),
                  SigavCardAction(
                    type: "detail",
                    title: "Seg, 31/01 - Aula 17",
                    desc: "Acompanhamento dos projetos",
                    link: "meet.com/abc-def-ghi",
                  ),
                ],
              )),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
          //   child: Container(
          //     color: Colors.black.withOpacity(0.5),
          //     child: Center(
          //       child: Container(
          //         padding: EdgeInsets.all(25),
          //         decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.circular(20)),
          //         child: Text("Teste"),
          //       ),
          //     ),
          //   ),
          // )
        ],
      )),
    );
  }

  // SingleChildScrollView

  void _onButtonPressed(String type) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        context: context,
        // isScrollControlled: true,
        builder: (context) {
          if (type == "presence") {
            return SigavPresence();
          }
          if (type == "presence-list") {
            return SigavPresenceList();
          }
          if (type == "question-list") {
            return SigavSurvey();
          }
          if (type == "question") {
            return SigavQuestion();
          }
          if (type == "note") {
            return SigavNote();
          }
          return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Text("Ação inválida",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)));
        });
  }
}