// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/screens/class_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';

class SigavCard extends StatelessWidget {
  final String title;
  final String desc;
  final String? code;
  final String? registration;
  final Icon icon;
  final VoidCallback action1;
  final VoidCallback action2;
  final bool active;
  final bool? student;

  const SigavCard(
      {required this.title,
      this.registration = null,
      required this.action1,
      required this.action2,
      required this.desc,
      required this.icon,
      this.code = null,
      this.student = null,
      this.active = true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: active ? 1 : 0.5,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 16.0,
        ),
        decoration: BoxDecoration(
            // color: Colors.blue.shade400,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black26)),
        child: InkWell(
          onTap: () {
            action2();
          },
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      icon,
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                      if (code != null) Spacer(),
                      if (code != null)
                        Icon(
                          Icons.qr_code,
                          color: Colors.black54,
                        ),
                      if (code != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(code!,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ),
                    ],
                  ),
                ),
                Text(desc,
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
                if (student == null || student == false)
                  Divider(
                    height: 20,
                    thickness: 1,
                    color: Colors.black26,
                  ),
                if (student == null || student == false)
                  Row(
                    children: [
                      Expanded(
                        child: SigavButton(
                          title: "Editar",
                          action: () {
                            action1();
                          },
                          small: true,
                          secondary: true,
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: SigavButton(
                          title: "Ver",
                          action: () {
                            action2();
                          },
                          small: true,
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
//
//

const Map<String, String> typeList = {
  'detail': 'Encontro',
  'presence': 'Presença',
  'presence-list': 'Lista de Presença',
  'question-list': 'Enquete',
  'question': 'Pergunta',
  'note': 'Nota de Aula',
};

class SigavCardAction extends StatelessWidget {
  final Map<String, dynamic> item;
  // final String type;
  // final String title;
  // final String desc;
  final VoidCallback? delete;
  // final String? link;
  // final int? deadline;
  // final List<dynamic> options;
  // final List<dynamic> replies;

  const SigavCardAction({
    required this.item,
    // required this.type,
    // required this.title,
    // required this.desc,
    this.delete = null,
    // this.link = "",
    // this.deadline = 0,
    // this.options = const [],
    // this.replies = const [],
  });

  @override
  Widget build(BuildContext context) {
    Color mainTextColor;
    if (item['type'] == "detail") {
      mainTextColor = Colors.white;
    } else {
      mainTextColor = Colors.black54;
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: item['type'] == "detail" ? Colors.blue.shade400 : null,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.black26)),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    item['type'] == "note"
                        ? Icon(
                            Icons.note,
                            color: mainTextColor,
                          )
                        : item['type'] == "question"
                            ? Icon(
                                Icons.chat_bubble,
                                color: mainTextColor,
                              )
                            : item['type'] == "question-list"
                                ? Icon(
                                    Icons.ballot,
                                    color: mainTextColor,
                                  )
                                : Icon(
                                    Icons.bookmark,
                                    color: mainTextColor,
                                  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(typeList[item['type']] ?? "Tipo Desconhecido",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainTextColor)),
                    ),
                  ],
                ),
              ),
              Text(item['text'],
                  style: TextStyle(fontSize: 18, color: mainTextColor)),
              ...(item['options'].map((item) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.radio_button_off,
                          color: mainTextColor,
                        ),
                      ),
                      Text(item,
                          style: TextStyle(fontSize: 18, color: mainTextColor)),
                    ],
                  ),
                );
              }).toList()),
              if (item['options'].length > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SigavButton(
                    title: "Votar",
                    action: () {
                      // action1();
                    },
                    small: true,
                    secondary: true,
                  ),
                ),
              if (item['file'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SigavButton(
                    title: "Baixar arquivo",
                    action: () {
                      // action1();
                    },
                    small: true,
                    secondary: true,
                  ),
                ),
              Container(
                child: item['link'] == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: mainTextColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(item['link']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: mainTextColor)),
                            ),
                          ],
                        ),
                      ),
              ),
              Divider(
                height: 20,
                thickness: 1,
                color: Colors.black26,
              ),
              Row(
                children: [
                  Text(
                      DateFormat("dd/MM/yyyy - hh:mm", 'pt_BR').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              item['createdAt'])),
                      style: TextStyle(fontSize: 14, color: mainTextColor)),
                  Spacer(),
                  if (delete != null)
                    InkWell(
                      onTap: () {
                        delete!();
                      },
                      child: Icon(
                        Icons.delete,
                        color: mainTextColor,
                        size: 18,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
