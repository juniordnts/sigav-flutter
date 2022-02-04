// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:html';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/screens/meet_add_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_field.dart';

class SigavPresence extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavPresence({Key? key, required this.item, this.session})
      : super(key: key);

  @override
  _SigavPresenceState createState() => _SigavPresenceState();
}

class _SigavPresenceState extends State<SigavPresence> {
  bool _loading = true;
  bool _allowPresence = true;

  @override
  void initState() {
    super.initState();
    _getItem();
  }

  void _getItem() async {
    setState(() {
      _loading = true;
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/professor/meet/one/' + widget.item['_id'],
          token: widget.session!.token);

      Map<String, dynamic> result = await request.get();
      if (result["success"]) {
        print(result);
        setState(() {
          _allowPresence = result["response"]["allowPresence"];
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      print(err);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _edit(bool presence) async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, dynamic> body = {
        'allowPresence': presence.toString(),
      };
      SigavApi request = SigavApi(
          path: '/v1/professor/meet/update/' + widget.item['_id'],
          body: body,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        _getItem();
        sigavDialog(context, result["message"], 'success');
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.lock_open,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Presença de aula",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _loading
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CircularProgressIndicator(
                      color: Colors.blue.shade400,
                    ),
                  ))
                : Row(
                    children: [
                      Expanded(
                        child: SigavButton(
                          title: "Aberta",
                          action: () {
                            _edit(true);
                          },
                          secondary: !_allowPresence,
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        child: SigavButton(
                          title: "Fechada",
                          action: () {
                            _edit(false);
                          },
                          secondary: _allowPresence,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

//
//
//

class SigavPresenceList extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavPresenceList({Key? key, required this.item, this.session})
      : super(key: key);

  @override
  _SigavPresenceListState createState() => _SigavPresenceListState();
}

class _SigavPresenceListState extends State<SigavPresenceList> {
  bool _loading = true;
  List<dynamic> itemList = [];
  List<dynamic> presence = [];

  @override
  void initState() {
    super.initState();
    _getItem();
  }

  void _getItem() async {
    setState(() {
      _loading = true;
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/professor/meet/one/' + widget.item['_id'],
          token: widget.session!.token);

      Map<String, dynamic> result = await request.get();
      if (result["success"]) {
        print(result);
        setState(() {
          presence = result["response"]["presence"];
        });
        _getNames(result["response"]["studentsId"]);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      print(err);
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  void _getNames(List<dynamic> names) async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    Map<String, dynamic> body = {"students": names};

    try {
      SigavApi request = SigavApi(
          body: body,
          path: '/v1/professor/meet/names',
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        print(result["response"]);
        setState(() {
          itemList = result["response"];
          _loading = false;
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      print(err);
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Lista de presença",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          if (_loading)
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
              ),
            )),
          ...(itemList.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Icon(
                    presence.contains(item['_id'])
                        ? Icons.check_circle
                        : Icons.remove,
                    color: presence.contains(item['_id'])
                        ? Colors.blue.shade400
                        : Colors.black38,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(item['name'],
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black54)),
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}

//
//
//

class SigavSurvey extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavSurvey({Key? key, required this.item, this.session})
      : super(key: key);
  @override
  _SigavSurveyState createState() => _SigavSurveyState();
}

class _SigavSurveyState extends State<SigavSurvey> {
  final TextEditingController _questionField = TextEditingController();
  final TextEditingController _answerField = TextEditingController();

  List itemList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  void _create(Map<String, String> body) async {
    setState(() {
      _loading = true;
    });

    try {
      body["meetId"] = widget.item['_id'];

      SigavApi request = SigavApi(
          path: '/v1/professor/card/create/' + widget.item['groupId'],
          body: body,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        await sigavDialog(context, result["message"], 'success');
        Navigator.pop(context, true);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.ballot,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Enquete",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SigavField(
                hint: 'Pergunta',
                controller: _questionField,
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: SigavField(
                    hint: 'Resposta',
                    controller: _answerField,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SigavCircleIcon(
                    blue: true,
                    action: () {
                      setState(() {
                        itemList = [...itemList, _answerField.text];
                      });
                      _answerField.text = "";
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          ...(itemList.asMap().entries.map((entry) {
            int index = entry.key;
            String item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: item,
                        hintStyle: TextStyle(color: Colors.black26),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black26)),
                      ),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SigavCircleIcon(
                      blue: true,
                      action: () {
                        setState(() {
                          itemList.removeAt(index);
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          }).toList()),
          Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: SigavButton(
                disabled: _loading,
                loading: _loading,
                title: "Adicionar",
                action: () {
                  _create({
                    'type': 'question-list',
                    'text': _questionField.text,
                    'options': json.encode(itemList),
                  });
                },
              )),
        ],
      ),
    );
  }
}

//
//
//

class SigavQuestion extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavQuestion({Key? key, required this.item, this.session})
      : super(key: key);
  @override
  _SigavQuestionState createState() => _SigavQuestionState();
}

class _SigavQuestionState extends State<SigavQuestion> {
  DateTime? selectedDate = null;
  final TextEditingController _textField = TextEditingController();

  bool _loading = false;
  bool _loadingFile = false;

  String? file = null;

  void _create() async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, String> body = {
        "meetId": widget.item['_id'],
        "type": "question",
        "text": _textField.text,
      };

      if (file != null) {
        body['file'] = file ?? "";
      }

      SigavApi request = SigavApi(
          path: '/v1/professor/card/create/' + widget.item['groupId'],
          body: body,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        await sigavDialog(context, result["message"], 'success');
        Navigator.pop(context, true);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if (result.files.single.path != null) {
        String path = result.files.single.path ?? "";
        // File file = File(path);
        _upload(path);
      }
    }
  }

  void _upload(String path) async {
    setState(() {
      _loadingFile = true;
    });

    try {
      SigavApi request =
          SigavApi(path: '/v1/user/upload/file', token: widget.session!.token);

      Map<String, dynamic> result = await request.upload(path);

      if (result["success"]) {
        setState(() {
          file = result["response"];
        });
        await sigavDialog(context, result["message"], 'success');
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.note,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Adicionar quetão",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: SigavField(
              hint: 'Questão',
              controller: _textField,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: SigavDateField(
              hint: "Data de entrega",
              selectedDate: selectedDate,
              onChange: (value) => setState(() {
                selectedDate = value;
              }),
            ),
          ),
          if (file != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.file_present_rounded,
                    color: Colors.black54,
                    size: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Arquivo anexo",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  )
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 18, top: 10),
            child: Expanded(
              child: SigavButton(
                title: file != null ? "Remover arquivo" : "Inserir arquivo",
                action: () {
                  if (file != null) {
                    setState(() {
                      file = null;
                    });
                  } else {
                    _pickFile();
                    // showCupertinoModalPopup<void>(
                    //   context: context,
                    //   builder: (BuildContext context) => CupertinoActionSheet(
                    //     title: const Text('Confirmar'),
                    //     message:
                    //         const Text('De onde deseja inserir o arquivo?'),
                    //     cancelButton: CupertinoActionSheetAction(
                    //       child: const Text('Cancelar'),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //     actions: <CupertinoActionSheetAction>[
                    //       CupertinoActionSheetAction(
                    //         child: const Text('Câmera'),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //           _pickFile();
                    //         },
                    //       ),
                    //       CupertinoActionSheetAction(
                    //         child: const Text('Arquivos'),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //           _pickFile();
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }
                },
                small: true,
                secondary: true,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: SigavButton(
                loading: _loading | _loadingFile,
                disabled: _loading | _loadingFile,
                title: "Adicionar",
                action: () {
                  _create();
                },
              )),
        ],
      ),
    );
  }
}

//
//
//

class SigavNote extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavNote({Key? key, required this.item, this.session})
      : super(key: key);
  @override
  _SigavNoteState createState() => _SigavNoteState();
}

class _SigavNoteState extends State<SigavNote> {
  final TextEditingController _textField = TextEditingController();

  bool _loading = false;

  void _create(Map<String, String> body) async {
    setState(() {
      _loading = true;
    });

    try {
      body["meetId"] = widget.item['_id'];

      SigavApi request = SigavApi(
          path: '/v1/professor/card/create/' + widget.item['groupId'],
          body: body,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        await sigavDialog(context, result["message"], 'success');
        Navigator.pop(context, true);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

// padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom)
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 18,
          left: 18,
          right: 18,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.note,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("Adicionar nota de aula",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: SigavField(
                hint: 'Nota',
                controller: _textField,
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: SigavButton(
                disabled: _loading,
                loading: _loading,
                title: "Adicionar",
                action: () {
                  _create({
                    'type': 'note',
                    'text': _textField.text,
                  });
                },
              )),
        ],
      ),
    );
  }
}

//
//
//

class SigavApplies extends StatefulWidget {
  final Map<String, dynamic> item;
  final Null Function(dynamic) setApplies;
  final Session? session;

  const SigavApplies(
      {Key? key, required this.item, required this.setApplies, this.session})
      : super(key: key);
  @override
  _SigavAppliesState createState() => _SigavAppliesState();
}

class _SigavAppliesState extends State<SigavApplies> {
  bool _loading = false;
  List itemList = [];

  void _update(String type, String studentId, int index) async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, dynamic> body = {
        "groupId": widget.item['_id'],
        "studentId": studentId
      };

      SigavApi request = SigavApi(
          path: '/v1/professor/group/student/' + type,
          body: body,
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        await sigavDialog(context, result["message"], 'success');
        itemList.removeAt(index);
        List updatedList = itemList.map((item) {
          return item['_id'];
        }).toList();
        widget.setApplies(updatedList);
        if (updatedList.isEmpty) Navigator.pop(context, true);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (e) {
      print(e);
      sigavDialog(context, "Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _getItems() async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    Map<String, dynamic> body = {"students": widget.item['applies']};

    try {
      SigavApi request = SigavApi(
          body: body,
          path: '/v1/professor/meet/names',
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        setState(() {
          itemList = result["response"];
          _loading = false;
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Lista de solicitações",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          if (_loading)
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
              ),
            )),
          if (!_loading)
            ...(itemList.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              return Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(item['name'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            _update('reprove', item['_id'], index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade600,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _update('aprove', item['_id'], index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue.shade400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
            }).toList()),
        ],
      ),
    );
  }
}

class SigavStudents extends StatefulWidget {
  final Map<String, dynamic> item;
  final Session? session;

  const SigavStudents({Key? key, required this.item, this.session})
      : super(key: key);
  @override
  _SigavStudentsState createState() => _SigavStudentsState();
}

class _SigavStudentsState extends State<SigavStudents> {
  bool _loading = false;
  List itemList = [];

  void _getItems() async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/professor/group/one/' + widget.item["_id"],
          token: widget.session!.token);

      Map<String, dynamic> result = await request.get();

      if (result["success"]) {
        _getNames(result["response"]["studentsId"]);
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      print(err);
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  void _getNames(List<dynamic> names) async {
    setState(() {
      _loading = true;
      itemList = [];
    });

    Map<String, dynamic> body = {"students": names};

    try {
      SigavApi request = SigavApi(
          body: body,
          path: '/v1/professor/meet/names',
          token: widget.session!.token);

      Map<String, dynamic> result = await request.post();

      if (result["success"]) {
        setState(() {
          itemList = result["response"];
          _loading = false;
        });
      } else {
        sigavDialog(context, result["message"], 'error');
      }
      print(result);
    } catch (err) {
      sigavDialog(context, "Erro", "error");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.format_list_numbered,
                  color: Colors.black54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Alunos",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Divider(
            height: 20,
            thickness: 1,
            color: Colors.black26,
          ),
          if (_loading)
            Center(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CircularProgressIndicator(
                color: Colors.blue.shade400,
              ),
            )),
          if (!_loading)
            ...(itemList.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> item = entry.value;
              return Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_pin_rounded,
                          color: Colors.blue.shade400,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(item['name'],
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black54)),
                        ),
                      ],
                    ),
                  ));
            }).toList()),
        ],
      ),
    );
  }
}
