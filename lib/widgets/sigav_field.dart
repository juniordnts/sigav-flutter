// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SigavField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final VoidCallback? rightIconAction;
  final VoidCallback? onChange;
  final Icon? rightIcon;
  final bool? hide;
  final bool? isInvalid;
  final TextInputType? type;

  const SigavField({
    required this.hint,
    required this.controller,
    this.rightIconAction = null,
    this.onChange = null,
    this.rightIcon,
    this.hide = false,
    this.isInvalid = false,
    this.type = null,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
            color: (isInvalid! ? Colors.red.shade800 : Colors.black26)),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 14, right: 14),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) => {if (onChange != null) onChange!()},
                  keyboardType: type,
                  obscureText: hide!,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                          color: (isInvalid!
                              ? Colors.red.shade800
                              : Colors.black26)),
                      border: InputBorder.none),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              if (rightIcon != null)
                InkWell(
                  onTap: () {
                    rightIconAction!();
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: isInvalid!
                          ? Icon(
                              rightIcon!.icon,
                              color: Colors.red.shade800,
                            )
                          : rightIcon),
                ),
              if (isInvalid!)
                InkWell(
                  onTap: () {
                    // rightIconAction!();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red.shade800,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
