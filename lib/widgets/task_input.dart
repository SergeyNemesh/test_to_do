import 'package:flutter/material.dart';
import 'package:test_to_do/app/palette.dart';

class TaskInput extends StatelessWidget {
  const TaskInput({
    super.key,
    this.isTitle = true,
    required this.onChange,
    this.initialValue,
  });

  final bool isTitle;
  final Function(String) onChange;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: (value) => onChange(value),
      maxLines: isTitle ? 1 : null,
      expands: isTitle ? false : true,
      textAlignVertical: TextAlignVertical.top,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: blackColor),
        ),
      ),
    );
  }
}
