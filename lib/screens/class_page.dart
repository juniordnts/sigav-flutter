// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sigav_app/helpers/database.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/helpers/sigav_defaults.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/screens/class_add_page.dart';
import 'package:sigav_app/screens/class_detail_page.dart';
import 'package:sigav_app/screens/login_page.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_card.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  final SigavDB _dbSigav = SigavDB();

  List itemList = [];

  Session? _session = Session(token: "", name: "", type: "", userId: "");
  bool _loading = false;
  bool _closedClasses = false;

  @override
  void initState() {
    super.initState();
    _dbSigav.getSession().then((session) {
      setState(() {
        _session = session;
      });
      _getItems();
    });
  }

  void _getItems() async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    try {
      Map<String, String> query = {};

      if (!_closedClasses) {
        query["active"] = 'true';
      }

      SigavApi request = SigavApi(
          path: '/v1/' + _session!.type + '/group/all',
          query: query,
          token: _session!.token);

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

  void _logout() async {
    await _dbSigav.deleteSession();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          title: "Turmas",
          subTitle: "Olá, " +
              (_session!.type == 'professor' ? "professor " : "aluno ") +
              (_session != null ? _session!.name : ""),
          leftAction: () {
            _logout();
          },
          leftIcon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          rightAction: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClassAddPage(session: _session)))
                .then((value) {
              if (value) _getItems();
            });
          },
          rightIcon: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        SigavBody(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  CupertinoSwitch(
                    value: _closedClasses,
                    activeColor: Colors.blue.shade400,
                    onChanged: (bool value) {
                      setState(() {
                        _closedClasses = value;
                      });
                      _getItems();
                    },
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
                    code: item["registration"],
                    active: item["active"],
                    registration: item["registration"],
                    title: item["name"],
                    student: _session!.type == "student",
                    action1: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassAddPage(
                                    item: item,
                                    session: _session,
                                  ))).then((value) {
                        if (value) _getItems();
                      });
                    },
                    action2: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassDetailPage(
                                    session: _session,
                                    item: item,
                                  )));
                    },
                    desc: item["description"],
                    icon: Icon(
                      Icons.folder_shared,
                      color: Colors.black54,
                    )),
              );
            }).toList()),
          ],
        )
      ],
    );
  }
}
