// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SigavButton extends StatelessWidget {
  final String title;
  final VoidCallback action;
  final bool? small;
  final bool? disabled;
  final bool? secondary;
  final bool? loading;
  final bool? red;

  const SigavButton({
    required this.title,
    required this.action,
    this.small,
    this.disabled = false,
    this.secondary,
    this.loading,
    this.red,
  });

  @override
  Widget build(BuildContext context) {
    Color mainColor;
    if (red == true) {
      mainColor = Colors.red.shade600;
    } else {
      mainColor = Colors.blue.shade400;
    }

    return Opacity(
      opacity: disabled! ? 0.5 : 1,
      child: Container(
        width: double.infinity,
        height: small == true ? 40 : 67,
        decoration: BoxDecoration(
          color: secondary == true ? null : mainColor,
          border: secondary == true ? Border.all(color: mainColor) : null,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: InkWell(
          onTap: () {
            if (!disabled!) action();
          },
          child: Padding(
            padding: small == true ? EdgeInsets.all(5) : EdgeInsets.all(20.0),
            child: Center(
              child: loading == true
                  ? SizedBox(
                      height: small == true ? 18 : 27,
                      width: small == true ? 18 : 27,
                      child: CircularProgressIndicator(
                        color: secondary == true ? mainColor : Colors.white,
                      ),
                    )
                  : Text(title,
                      style: TextStyle(
                          fontSize: small == true ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: secondary == true ? mainColor : Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}

class SigavCircleIcon extends StatelessWidget {
  final Icon icon;
  final VoidCallback action;
  final bool? disabled;
  final bool? blue;

  const SigavCircleIcon(
      {required this.icon, required this.action, this.blue, this.disabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: blue == true ? Colors.blue.shade400 : null,
            border: blue == true ? null : Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(30)),
        child: icon,
      ),
    );
  }
}
