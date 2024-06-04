import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/app/palette.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.errorText,
    required this.onChange,
  });

  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? errorText;
  final Function(String) onChange;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isHidePassword = true;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70.h,
        child: TextFormField(
          controller: widget.controller,
          maxLines: 1,
          maxLength: 20,
          obscureText: (widget.isPassword && isHidePassword),
          onChanged: (value) => widget.onChange(value),
          keyboardType: widget.isPassword ? null : TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: blackColor),
            ),
            errorText: widget.errorText,
            suffixIcon: !widget.isPassword
                ? null
                : GestureDetector(
                    onTap: () {
                      setState(() => isHidePassword = !isHidePassword);
                    },
                    child:
                        isHidePassword ? const Icon(Icons.remove_red_eye_outlined) : const Icon(Icons.remove_red_eye),
                  ),
          ),
        ),
      );
}
