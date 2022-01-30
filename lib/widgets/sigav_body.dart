// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sigav_app/helpers/scroll_glow.dart';

class SigavBody extends StatelessWidget {
  final List<Widget>? children;
  final bool? centered;

  const SigavBody({this.children = const [], this.centered = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          width: double.infinity,
          color: Colors.grey[100],
          child: ScrollConfiguration(
            behavior: NoScrollGlow(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 8.0),
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: centered!
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: children!),
              ),
            ),
          )),
    );
  }
}
