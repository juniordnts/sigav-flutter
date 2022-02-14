// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:file_picker/file_picker.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:path/path.dart' as dPath;
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/helpers/sigav_defaults.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/screens/class_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';

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

class SigavCardAction extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session session;
  final VoidCallback? delete;
  // final String type;
  // final String title;
  // final String desc;
  // final String? link;
  // final int? deadline;
  // final List<dynamic> options;
  // final List<dynamic> replies;

  const SigavCardAction(
      {Key? key, required this.item, required this.session, this.delete = null})
      : super(key: key);
  // required this.type,
  // required this.title,
  // required this.desc,
  // this.link = "",
  // this.deadline = 0,
  // this.options = const [],
  // this.replies = const [],

  @override
  _SigavCardActionState createState() => _SigavCardActionState();
}

class _SigavCardActionState extends State<SigavCardAction> {
  bool haveSend = false;
  bool _loadingFile = false;
  bool _loadingSubmit = false;
  String? fileLocal = null;
  String? file = null;

  ReceivePort _port = ReceivePort();

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  void dispose() {
    super.dispose();
    // IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  void initState() {
    super.initState();
    if ((widget.item['replies'].singleWhere((it) {
          return it["student"] == widget.session.userId;
        }, orElse: () => null)) !=
        null) {
      setState(() {
        haveSend = true;
      });
    }

    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];
    //   setState(() {});
    // });
  }

  void _requestDownload(String url) async {
    await FlutterDownloader.registerCallback(downloadCallback);
    var externalStorageDirPath = await getExternalStorageDirectory();
    await FlutterDownloader.enqueue(
      url:
          "http://34.68.226.171/uploads/files/1644468827064-Screenshot_20220210-011425.jpg",
      savedDir: externalStorageDirPath!.path,
      showNotification: true,
      openFileFromNotification: true,
      saveInPublicStorage: true,
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.files.single.path != null) {
        String path = result.files.single.path ?? "";
        String name = result.files.single.name;
        // File file = File(path);
        _upload(path, name);
      }
    }
  }

  void _upload(String path, String name) async {
    setState(() {
      _loadingFile = true;
    });

    try {
      SigavApi request =
          SigavApi(path: '/v1/user/upload/file', token: widget.session.token);

      Map<String, dynamic> result = await request.upload(path);

      if (result["success"]) {
        setState(() {
          file = result["response"];
          fileLocal = name;
        });
        await sigavDialog(context, "Arquivo carregado", 'success');
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loadingFile = false;
      });
    }
  }

  void _submit() async {
    setState(() {
      _loadingSubmit = true;
    });

    try {
      Map<String, String> body = {
        "file": file ?? "",
      };

      SigavApi request = SigavApi(
          path: '/v1/student/card/reply/' + widget.item['_id'],
          body: body,
          token: widget.session.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        await sigavDialog(context, result["message"], 'success');
        setState(() {
          haveSend = true;
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loadingSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainTextColor;
    if (widget.item['type'] == "detail") {
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
          color: widget.item['type'] == "detail" ? Colors.blue.shade400 : null,
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
                    widget.item['type'] == "note"
                        ? Icon(
                            Icons.note,
                            color: mainTextColor,
                          )
                        : widget.item['type'] == "question"
                            ? Icon(
                                Icons.chat_bubble,
                                color: mainTextColor,
                              )
                            : widget.item['type'] == "question-list"
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
                      child: Text(
                          typeList[widget.item['type']] ?? "Tipo Desconhecido",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: mainTextColor)),
                    ),
                  ],
                ),
              ),
              Text(widget.item['text'],
                  style: TextStyle(fontSize: 18, color: mainTextColor)),
              ...(widget.item['options'].map((iterator) {
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
                      Text(iterator,
                          style: TextStyle(fontSize: 18, color: mainTextColor)),
                    ],
                  ),
                );
              }).toList()),
              if (widget.item['options'].length > 0)
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
              if (widget.item['file'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SigavButton(
                    title: "Baixar arquivo",
                    action: () {
                      _requestDownload(widget.item['file']);
                    },
                    small: true,
                    secondary: true,
                  ),
                ),
              if (widget.item['submit'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.timer_outlined,
                          color: mainTextColor,
                          size: 18,
                        ),
                      ),
                      Text(
                          "Entrega: " +
                              DateFormat("dd/MM/yyyy - hh:mm", 'pt_BR').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      widget.item['submit'])),
                          style: TextStyle(fontSize: 14, color: mainTextColor)),
                      if (haveSend == true) Spacer(),
                      if (haveSend == true)
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.blue.shade400,
                                size: 18,
                              ),
                            ),
                            Text("Entregue",
                                style: TextStyle(
                                    fontSize: 14, color: mainTextColor)),
                          ],
                        ),
                    ],
                  ),
                ),
              if (haveSend == false &&
                  widget.item['type'] == 'question' &&
                  widget.session.type == "student")
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SigavButton(
                    title: "Escolher arquivo",
                    loading: _loadingFile,
                    action: () {
                      _pickFile();
                    },
                    small: true,
                    secondary: true,
                  ),
                ),
              if (file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.file_present,
                          color: Colors.blue.shade400,
                          size: 18,
                        ),
                      ),
                      Expanded(
                        child: Text(fileLocal ?? "",
                            overflow: TextOverflow.clip,
                            style:
                                TextStyle(fontSize: 14, color: mainTextColor)),
                      ),
                    ],
                  ),
                ),
              if (haveSend == false &&
                  widget.item['type'] == 'question' &&
                  file != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SigavButton(
                    title: "Submeter",
                    loading: _loadingSubmit,
                    action: () {
                      _submit();
                    },
                    small: true,
                  ),
                ),
              Container(
                child: widget.item['link'] == null
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
                              child: Text(widget.item['link']!,
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
                              widget.item['createdAt'])),
                      style: TextStyle(fontSize: 14, color: mainTextColor)),
                  Spacer(),
                  if (widget.delete != null)
                    InkWell(
                      onTap: () {
                        widget.delete!();
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
