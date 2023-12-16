import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onSubmitted;
  final int? maxLines;
  final Widget? icon;
  final Function(String)? onChanged;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.textInputType = TextInputType.text,
    this.onSubmitted,
    this.maxLines,
    this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        keyboardType: textInputType,
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: false,
          icon: icon,
        ),
      ),
    );
  }
}
