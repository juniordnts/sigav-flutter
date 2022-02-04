// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/screens/class_add_page.dart';
import 'package:sigav_app/screens/meet_add_page.dart';
import 'package:sigav_app/screens/meet_detail_page.dart';
import 'package:sigav_app/widgets/sigav_actions.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class ClassDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const ClassDetailPage({Key? key, required this.item, this.session})
      : super(key: key);

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  List itemList = [];
  bool _loading = false;

  List appliesList = [];

  @override
  void initState() {
    super.initState();

    _getItems();
    setState(() {
      appliesList = widget.item['applies'];
    });
  }

  void _getItems() async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    try {
      SigavApi request = SigavApi(
          path:
              '/v1/' + widget.session!.type + '/meet/all/' + widget.item["_id"],
          token: widget.session!.token);

      Map<String, dynamic> result = await request.get();
      if (result["success"]) {
        setState(() {
          itemList = result["response"];
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          customTitle: [
            Text("Turma",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Row(
              children: [
                Icon(
                  Icons.folder_shared,
                  color: Colors.white,
                  size: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.item["name"],
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
          leftAction: () => Navigator.pop(context),
          leftIcon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          rightAction: widget.session!.type == 'professor'
              ? () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClassAddPage(
                          item: widget.item, session: widget.session)))
              : null,
          rightIcon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        SigavBody(
          children: [
            if (appliesList.isNotEmpty && widget.session!.type != "student")
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavButton(
                  title: appliesList.length.toString() +
                      (appliesList.length > 1
                          ? " Solicitações"
                          : " Solicitação") +
                      " para entrar",
                  action: () {
                    _onButtonPressed('applies');
                  },
                  small: true,
                  secondary: true,
                ),
              ),
            if (!appliesList.isNotEmpty && widget.session!.type != "student")
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavButton(
                  title: "Alunos",
                  action: () {
                    _onButtonPressed('students');
                  },
                  small: true,
                  secondary: true,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Encontros",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                  Spacer(),
                  if (widget.session!.type != "student")
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MeetAddPage(
                                      itemParent: widget.item,
                                      session: widget.session,
                                    ))).then((value) {
                          if (value) _getItems();
                        });
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
            if (_loading)
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CircularProgressIndicator(
                  color: Colors.blue.shade400,
                ),
              )),
            ...(itemList.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: SigavCard(
                    student: widget.session!.type == "student",
                    title: DateFormat("E, dd/MM - ", 'pt_BR').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                item!["date"])) +
                        item["name"],
                    active: item!["active"] ?? false,
                    action1: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MeetAddPage(
                                    item: item,
                                    itemParent: widget.item,
                                    session: widget.session,
                                  ))).then((value) {
                        if (value) _getItems();
                      });
                    },
                    action2: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MeetDetailPage(
                                    item: item,
                                    session: widget.session,
                                  )));
                    },
                    desc: item["description"],
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.black54,
                    )),
              );
            }).toList()),
          ],
        )
      ],
    );
  }

  void _onButtonPressed(String type) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        context: context,
        // isScrollControlled: true,
        builder: (context) {
          return type == "applies"
              ? SigavApplies(
                  setApplies: (value) {
                    setState(() {
                      appliesList = value;
                    });
                  },
                  item: widget.item,
                  session: widget.session,
                )
              : SigavStudents(
                  item: widget.item,
                  session: widget.session,
                );
        }).then((value) {
      if (value != null) {
        // _getItems();
      }
    });
  }
}
