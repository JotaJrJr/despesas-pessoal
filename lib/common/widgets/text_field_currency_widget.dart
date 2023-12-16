import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCurrencyWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String)? onSubmitted;
  final int? maxLines;
  final Widget? icon;
  final TextInputFormatter? textInputFormatter;
  final bool? isCurrencyMoney;
  final void Function(String)? onChanged;

  const TextFieldCurrencyWidget({
    super.key,
    this.controller,
    this.textInputType = TextInputType.text,
    this.onSubmitted,
    this.maxLines,
    this.icon,
    this.textInputFormatter,
    this.isCurrencyMoney,
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
        onChanged: (value) => onChanged,
        inputFormatters: textInputFormatter == null
            ? []
            : [
                FilteringTextInputFormatter.allow(isCurrencyMoney != null && isCurrencyMoney == true ? RegExp(r'[0-9]') : RegExp(r'[a-zA-z-0-9]+')),
                textInputFormatter!,
              ],
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
