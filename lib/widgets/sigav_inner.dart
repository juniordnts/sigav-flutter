// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SigavInner extends StatelessWidget {
  final List<Widget>? children;

  const SigavInner({this.children = const []});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: children!)),
      ),
    );
  }
}

// BackdropFilter(
//   filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
//   child: Container(
//     color: Colors.black.withOpacity(0.5),
//     child: Center(
//       child: Container(
//         padding: EdgeInsets.all(25),
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20)),
//         child: Text("Teste"),
//       ),
//     ),
//   ),
// )