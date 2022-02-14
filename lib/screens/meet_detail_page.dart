// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/widgets/sigav_actions.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_card.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class MeetDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const MeetDetailPage({Key? key, required this.item, this.session})
      : super(key: key);

  @override
  _MeetDetailPageState createState() => _MeetDetailPageState();
}

class _MeetDetailPageState extends State<MeetDetailPage> {
  final Map<String, String> typeList = {
    'presence': 'Presença',
    'presence-list': 'Lista de Presença',
    'question-list': 'Votação',
    'question': 'Pergunta',
    'note': 'Nota de Aula',
  };

  bool _loading = false;
  bool _loadingCreate = false;
  bool _loadingPresence = false;
  List itemList = [];

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  void _getItems() async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    try {
      SigavApi request = SigavApi(
          query: {
            "groupId": widget.item['groupId'],
            "meetId": widget.item['_id'],
          },
          path: '/v1/' + widget.session!.type + '/card/all',
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

  void _remove(String cardId) async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/professor/card/remove/' + cardId,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        sigavDialog(context, result["message"], 'success');
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      _getItems();
    }
  }

  void _sendPresence() async {
    setState(() {
      _loadingPresence = true;
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/student/meet/presence/' + widget.item['_id'],
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();
      if (result["success"]) {
        sigavDialog(context, result["message"], 'success');
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loadingPresence = false;
      });
    }
  }

  void _handleDelete(String cardId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Confirmar'),
        message: const Text('Você realmente deseja remover?'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Remover'),
            onPressed: () {
              Navigator.pop(context);
              _remove(cardId);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          customTitle: [
            Text(
                "Encontro" +
                    DateFormat(" - E, dd/MM/yyyy", 'pt_BR').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.item["date"])),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: Colors.white,
                  size: 32,
                ),
                Expanded(
                  child: Text(widget.item["name"],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
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
        ),
        SigavBody(
          children: [
            if (widget.session!.type == "student")
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavButton(
                  loading: _loadingPresence,
                  disabled: _loadingPresence,
                  title: "Enviar presença",
                  action: () {
                    _sendPresence();
                  },
                  small: true,
                  // secondary: true,
                ),
              ),
            if (widget.session!.type != "student")
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text("Ações",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
              ),
            if (widget.session!.type != "student")
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
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
                            Icons.lock,
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
              padding: const EdgeInsets.only(bottom: 16),
              child: Text("Linha do tempo",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ),
            if (_loading)
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CircularProgressIndicator(
                  color: Colors.blue.shade400,
                ),
              )),
            //
            // type
            // text
            // link
            // options
            // replies
            //
            ...(itemList.map((item) {
              return SigavCardAction(
                item: item,
                session: widget.session!,
                // type: item['type'],
                // title: typeList[item['type']] ?? "Tipo Desconhecido",
                // desc: item['text'],
                // link: item['link'],
                // deadline: item['deadline'],
                // options: item['options'],
                // replies: item['replies'],
                delete: widget.session!.type == "professor"
                    ? () => _handleDelete(item["_id"])
                    : null,
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
        isScrollControlled: true,
        builder: (context) {
          if (type == "presence") {
            return SigavPresence(
              session: widget.session,
              item: widget.item,
            );
          }
          if (type == "presence-list") {
            return SigavPresenceList(
              session: widget.session,
              item: widget.item,
            );
          }
          if (type == "question-list") {
            return SigavSurvey(
              session: widget.session,
              item: widget.item,
            );
          }
          if (type == "question") {
            return SigavQuestion(
              session: widget.session,
              item: widget.item,
            );
          }
          if (type == "note") {
            return SigavNote(
              session: widget.session,
              item: widget.item,
            );
          }
          return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Text("Ação inválida",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)));
        }).then((value) {
      if (value != null) {
        _getItems();
      }
    });
  }
}
