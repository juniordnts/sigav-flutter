// ignore_for_file: avoid_print, void_checks, prefer_const_constructors, unused_element
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sigav_app/helpers/sigav_defaults.dart';
import 'package:sigav_app/screens/login_page.dart';

import 'package:sigav_app/widgets/sigav_field.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_header.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String _typeField = "professor";
  bool _btnContinueDisable = true;

  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _phoneField = TextEditingController();
  final TextEditingController _registrationField = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void checkAllFieldsValid() {
    if (_nameField.text != "" &&
        _phoneField.text != "" &&
        _registrationField.text != "") {
      setState(() {
        _btnContinueDisable = false;
      });
    } else if (!_btnContinueDisable) {
      setState(() {
        _btnContinueDisable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          title: "Criar Conta",
          leftAction: () => Navigator.pop(context),
          leftIcon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        SigavBody(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SigavButton(
                      title: "Professor",
                      action: () {
                        setState(() {
                          _typeField = "professor";
                        });
                      },
                      small: true,
                      secondary: _typeField != "professor",
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: SigavButton(
                      title: "Aluno",
                      action: () {
                        setState(() {
                          _typeField = "student";
                        });
                      },
                      small: true,
                      secondary: _typeField != "student",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Nome',
                  controller: _nameField,
                  onChange: () => checkAllFieldsValid(),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  type: TextInputType.phone,
                  hint: 'Telefone',
                  controller: _phoneField,
                  onChange: () => checkAllFieldsValid(),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Matrícula',
                  controller: _registrationField,
                  onChange: () => checkAllFieldsValid(),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: SigavButton(
                  disabled: _btnContinueDisable,
                  title: "Continuar",
                  action: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FinishSigninPage(
                                  type: _typeField,
                                  name: _nameField.text,
                                  phone: _phoneField.text,
                                  registration: _registrationField.text,
                                )));
                  },
                )),
          ],
        ),
      ],
    );
  }
}

//
//
//
//
//

class FinishSigninPage extends StatefulWidget {
  final String type;
  final String name;
  final String phone;
  final String registration;

  const FinishSigninPage(
      {Key? key,
      required this.type,
      required this.name,
      required this.phone,
      required this.registration})
      : super(key: key);

  @override
  _FinishSigninPageState createState() => _FinishSigninPageState();
}

class _FinishSigninPageState extends State<FinishSigninPage> {
  bool hidePassword = true;
  bool _loading = false;
  bool _btnContinueDisable = true;

  bool _emailInvalid = false;
  bool _passwordInvalid = false;
  bool _passwordRepeatInvalid = false;

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _passwordRepeatField = TextEditingController();

  void checkAllFieldsValid() {
    bool allValid = true;

    if (_emailField.text == "") {
      allValid = false;
      setState(() {
        _emailInvalid = true;
      });
    } else {
      setState(() {
        _emailInvalid = false;
      });
    }

    if (_passwordField.text == "") {
      allValid = false;
      setState(() {
        _passwordInvalid = true;
      });
    } else {
      setState(() {
        _passwordInvalid = false;
      });
    }

    if (_passwordField.text != _passwordRepeatField.text) {
      allValid = false;
      setState(() {
        _passwordRepeatInvalid = true;
      });
    } else {
      setState(() {
        _passwordRepeatInvalid = false;
      });
    }

    if (allValid) {
      setState(() {
        _btnContinueDisable = false;
      });
    } else if (!_btnContinueDisable) {
      setState(() {
        _btnContinueDisable = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _signin() async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, String> body = {
        'type': widget.type,
        'name': widget.name,
        'phone': widget.phone,
        'registration': widget.registration,
        'email': _emailField.text,
        'password': _passwordField.text,
      };

      Uri uri = Uri.http(SigavDef.url, '/v1/user/create');

      http.Response response = await http.post(
        uri,
        body: body,
      );

      Map<String, dynamic> result = json.decode(response.body);
      if (result["success"]) {
        setState(() {
          _loading = false;
        });
        await _showDialog("Conta criada", "success");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          ),
          (route) => false,
        );
      } else {
        _showDialog(result["message"], "error");
      }
      print(result);
    } catch (e) {
      _showDialog("Erro", "error");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future _showDialog(String message, String type) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                if (type == "success")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.blue.shade400,
                      size: 32,
                    ),
                  ),
                if (type == "info")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: Colors.blue.shade400,
                      size: 32,
                    ),
                  ),
                if (type == "error")
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.red.shade600,
                      size: 32,
                    ),
                  ),
                Text(message,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54)),
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        );
      },
    );
    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavHeader(
          title: "Criar conta",
          subTitle: "Professor",
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
                  hint: 'Email',
                  isInvalid: _emailInvalid,
                  controller: _emailField,
                  onChange: () => checkAllFieldsValid(),
                )),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Senha',
                  isInvalid: _passwordInvalid,
                  controller: _passwordField,
                  hide: true,
                  onChange: () => checkAllFieldsValid(),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SigavField(
                hint: 'Repetir senha',
                isInvalid: _passwordRepeatInvalid,
                controller: _passwordRepeatField,
                hide: hidePassword,
                onChange: () => checkAllFieldsValid(),
                rightIcon: Icon(
                  hidePassword
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined,
                  color: Colors.black26,
                ),
                rightIconAction: () => setState(() {
                  hidePassword = !hidePassword;
                }),
              ),
            ),
            SigavButton(
              disabled: _loading || _btnContinueDisable,
              loading: _loading,
              title: "Criar",
              action: () => _signin(),
            ),
          ],
        )
      ],
    );
  }
}
