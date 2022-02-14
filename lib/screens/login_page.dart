// ignore_for_file: avoid_print, void_checks
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/database.dart';
import 'package:sigav_app/helpers/sigav_defaults.dart';
import 'package:sigav_app/models/session.dart';

import 'package:sigav_app/screens/class_page.dart';
import 'package:sigav_app/screens/login_add_page.dart';
import 'package:sigav_app/widgets/sigav_body.dart';
import 'package:sigav_app/widgets/sigav_button.dart';
import 'package:sigav_app/widgets/sigav_dialog.dart';
import 'package:sigav_app/widgets/sigav_field.dart';
import 'package:sigav_app/widgets/sigav_inner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final SigavDB _dbSigav = SigavDB();

  bool _loading = true;
  bool hidePassword = true;

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailField.text = "jackson@email.com";
    _passwordField.text = "123";

    _dbSigav.getSession().then((session) {
      if (session != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ClassPage(),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          _loading = false;
        });
      }
    });
  }

  void _login() async {
    setState(() {
      _loading = true;
    });

    try {
      Map<String, String> body = {
        'email': _emailField.text,
        'password': _passwordField.text,
      };

      Uri uri = Uri.http(SigavDef.url, '/v1/user/login');

      http.Response response = await http.post(
        uri,
        body: body,
      );

      Map<String, dynamic> result = json.decode(response.body);
      if (result["success"]) {
        Session session = Session(
            token: result["token"],
            type: result["type"],
            name: result["name"],
            userId: result["_id"]);
        await _dbSigav.createSession(session);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ClassPage(),
          ),
          (route) => false,
        );
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

  @override
  Widget build(BuildContext context) {
    return SigavInner(
      children: [
        SigavBody(
          centered: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Image(
                height: 200,
                image: AssetImage('assets/images/login_sigav.png'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text("Sistema de Gestão de Aulas Virtuais",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54))),
            Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SigavField(
                  hint: 'Email',
                  controller: _emailField,
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SigavField(
                hint: 'Repetir senha',
                controller: _passwordField,
                hide: hidePassword,
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
            Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: SigavButton(
                  disabled: _loading,
                  loading: _loading,
                  title: "Login",
                  action: () => _login(),
                )),
            GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SigninPage()))
              },
              child: Text("Criar conta",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            )
          ],
        )
      ],
    );
  }
}
