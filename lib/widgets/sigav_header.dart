// ignore_for_file: use_key_in_widget_constructors, avoid_print
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sigav_app/widgets/sigav_button.dart';

class SigavHeader extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final List<Widget>? customTitle;
  final VoidCallback? leftAction;
  final VoidCallback? rightAction;
  final Icon? leftIcon;
  final Icon? rightIcon;

  const SigavHeader(
      {this.title,
      this.subTitle,
      this.customTitle = const [],
      this.leftAction,
      this.rightAction,
      this.leftIcon,
      this.rightIcon});

  Widget? _getLeftButton() {
    if (leftAction != null) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SigavCircleIcon(action: () => leftAction!(), icon: leftIcon!));
    }
    return Spacer();
  }

  Widget? _getRightButton() {
    if (rightAction != null) {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child:
              SigavCircleIcon(action: () => rightAction!(), icon: rightIcon!));
    }
    return Spacer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.blue.shade400,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _getLeftButton()!,
              Spacer(),
              _getRightButton()!,
            ],
          ),
          if (title != null)
            Text(title!,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          if (subTitle != null)
            Text(subTitle!,
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ...customTitle!
        ],
      ),
    );
  }
}
