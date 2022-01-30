// ignore_for_file: avoid_print, void_checks
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sigav_app/screens/class_page.dart';
import 'package:sigav_app/screens/login_add_page.dart';
import 'package:sigav_app/widgets/sigav_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List _todoList = [];

  Map<String, dynamic> _lastRemoved = Map();
  int _lastRemovedPos = 0;

  TextEditingController _titleController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   DatabaseHelper.retrieveDatabase().then((data) {
  //     setState(() {
  //       _todoList = json.decode(data);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        constraints: BoxConstraints.expand(),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black26)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black38))),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          hintText: "Senha",
                          hintStyle: TextStyle(color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black26)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black38))),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 26.0),
                      child: SigavButton(
                        title: "Login",
                        action: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClassPage()));
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SigninPage()))
                        },
                        child: Text("Criar conta",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ))
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
