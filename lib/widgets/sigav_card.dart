// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

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

  const SigavCard(
      {required this.title,
      this.registration = null,
      required this.action1,
      required this.action2,
      required this.desc,
      required this.icon,
      this.code = null,
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
                Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.black26,
                ),
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

class SigavCardAction extends StatelessWidget {
  final String type;
  final String title;
  final String desc;
  final bool active;
  final String link;

  const SigavCardAction(
      {required this.type,
      required this.title,
      required this.desc,
      this.active = true,
      this.link = ""});

  @override
  Widget build(BuildContext context) {
    Color mainTextColor;
    if (type == "detail") {
      mainTextColor = Colors.white;
    } else {
      mainTextColor = Colors.black54;
    }

    return Opacity(
      opacity: active ? 1 : 0.5,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
            color: type == "detail" ? Colors.blue.shade400 : null,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.black26)),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ClassPage()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      type == "note"
                          ? Icon(
                              Icons.note,
                              color: mainTextColor,
                            )
                          : type == "note"
                              ? Icon(
                                  Icons.bookmark,
                                  color: mainTextColor,
                                )
                              : Icon(
                                  Icons.bookmark,
                                  color: mainTextColor,
                                ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainTextColor)),
                      ),
                    ],
                  ),
                ),
                Text(desc,
                    style: TextStyle(fontSize: 18, color: mainTextColor)),
                Container(
                  child: link == ""
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
                                child: Text(link,
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
                Text('06/12/2021 16:35',
                    style: TextStyle(fontSize: 14, color: mainTextColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
