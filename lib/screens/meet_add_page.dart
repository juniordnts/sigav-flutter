// ignore_for_file: avoid_print, void_checks, prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

// import 'package:f_list_ex/database_helper.dart';
// import 'package:f_list_ex/widgets.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/sigav_api.dart';
import 'package:sigav_app/models/session.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_field.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class MeetAddPage extends StatefulWidget {
  final Map<String, dynamic>? item;
  final Map<String, dynamic> itemParent;
  final Session? session;

  const MeetAddPage(
      {Key? key,
      this.item = null,
      required this.itemParent,
      this.session = null})
      : super(key: key);

  @override
  _MeetAddPageState createState() => _MeetAddPageState();
}

class _MeetAddPageState extends State<MeetAddPage> {
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _descField = TextEditingController();
  final TextEditingController _linkField = TextEditingController();
  DateTime? selectedDate = null;

  bool _loading = false;
  bool _loadingDelete = false;
  bool _active = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameField.text = widget.item!['name'];
      _descField.text = widget.item!['description'];
      _linkField.text = widget.item!['link'];
      setState(() {
        _active = widget.item!['active'];
        selectedDate =
            DateTime.fromMillisecondsSinceEpoch(widget.item!['date']);
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
        'date': "${selectedDate!.millisecondsSinceEpoch}",
        'link': _linkField.text,
      };

      SigavApi request = SigavApi(
          path: '/v1/professor/meet/create/' + widget.itemParent["_id"],
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
      Map<String, dynamic> body = {
        'name': _nameField.text,
        'description': _descField.text,
        'date': selectedDate!.millisecondsSinceEpoch.toString(),
        'link': _linkField.text,
        'active': _active.toString(),
      };
      print('aaaaaaaaa');
      print(body);
      SigavApi request = SigavApi(
          path: '/v1/professor/meet/update/' + widget.item!['_id'],
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
          path: '/v1/professor/meet/remove/' + widget.item!['_id'],
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

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          title: widget.item == null ? "Criar encontro" : "Editar encontro",
          customTitle: [
            Row(
              children: [
                Icon(
                  Icons.folder_shared,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(widget.itemParent["name"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            )
          ],
          leftAction: () => Navigator.pop(context),
          leftIcon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        SigavBody(
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Nome',
                  controller: _nameField,
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Descrição',
                  controller: _descField,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SigavDateField(
                hint: "Data",
                selectedDate: selectedDate,
                onChange: (value) => setState(() {
                  selectedDate = value;
                }),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  type: TextInputType.url,
                  hint: 'Link',
                  controller: _linkField,
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
                      child: Text("Encontro aberto",
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
                  title: widget.item == null ? "Criar" : "Editar",
                  action: () {
                    if (widget.item == null) {
                      _create();
                    } else {
                      _edit();
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
        )
      ],
    );
  }
}
