// ignore_for_file: avoid_print, void_checks
// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';

Future<void> sigavDialog(
    BuildContext context, String message, String type) async {
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
