// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/helpers/sigav_defaults.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_field.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class ClassAddPage extends StatefulWidget {
  final Map<String, dynamic>? item;
  final Session? session;

  const ClassAddPage({Key? key, this.item = null, this.session = null})
      : super(key: key);

  @override
  _ClassAddPageState createState() => _ClassAddPageState();
}

class _ClassAddPageState extends State<ClassAddPage> {
  bool _loading = false;
  bool _loadingDelete = false;
  bool _active = false;

  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _descField = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameField.text = widget.item!['name'];
      _descField.text = widget.item!['description'];
      setState(() {
        _active = widget.item!['active'];
      });
    }
  }

  void _create() async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, String> body = {
        'name': _nameField.text,
        'description': _descField.text,
      };

      SigavApi request = SigavApi(
          path: '/v1/professor/group/create',
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

  void _edit() async {
    setState(() {
      _loading = true;
    });

    try {
      print(_active.runtimeType);
      Map<String, dynamic> body = {
        'name': _nameField.text,
        'description': _descField.text,
        'active': _active.toString(),
      };
      print(body);
      SigavApi request = SigavApi(
          path: '/v1/professor/group/update/' + widget.item!['_id'],
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

  void _remove() async {
    setState(() {
      _loadingDelete = true;
    });

    try {
      SigavApi request = SigavApi(
          path: '/v1/professor/group/remove/' + widget.item!['_id'],
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
        _loadingDelete = false;
      });
    }
  }

  void _apply() async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, String> body = {
        'registration': _nameField.text,
      };

      SigavApi request = SigavApi(
          path: '/v1/student/group/apply',
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
    return SigavInner(
      children: [
        SigavHeader(
          title: widget.item == null
              ? widget.session!.type == "student"
                  ? "Entrar na turma"
                  : "Criar turma"
              : "Editar turma",
          leftAction: () => Navigator.pop(context),
          leftIcon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        SigavBody(
          children: [
            if (widget.item != null)
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(widget.item!['registration'],
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Share.share(widget.item!['registration']);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.share,
                          color: Colors.black38,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            if (widget.session!.type == "student")
              Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SigavField(
                    rightIcon: Icon(
                      Icons.qr_code,
                      color: Colors.black38,
                    ),
                    rightIconAction: () {},
                    hint: 'Código',
                    controller: _nameField,
                  )),
            if (widget.session!.type != "student")
              Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SigavField(
                    hint: 'Nome',
                    controller: _nameField,
                  )),
            if (widget.session!.type != "student")
              Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SigavField(
                    hint: 'Descrição',
                    controller: _descField,
                  )),
            if (widget.item != null)
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    CupertinoSwitch(
                      value: _active,
                      activeColor: Colors.blue.shade400,
                      onChanged: (bool value) {
                        setState(() {
                          _active = value;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Turma aberta",
                          style:
                              TextStyle(fontSize: 18, color: Colors.black54)),
                    )
                  ],
                ),
              ),
            Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: SigavButton(
                  disabled: _loadingDelete || _loading,
                  loading: _loading,
                  title: widget.item == null
                      ? widget.session!.type == "student"
                          ? "Solicitar"
                          : "Criar"
                      : "Editar",
                  action: () {
                    print(widget.session!.type);
                    if (widget.session!.type == "student") {
                      _apply();
                    } else {
                      if (widget.item == null) {
                        _create();
                      } else {
                        _edit();
                      }
                    }
                  },
                )),
            if (widget.item != null)
              SigavButton(
                disabled: _loadingDelete || _loading,
                loading: _loadingDelete,
                red: true,
                title: "Remover",
                action: () {
                  _remove();
                },
              )
          ],
        ),
      ],
    );
  }
}
