import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_to_do/app/palette.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.title,
    required this.isLoading,
    required this.onTap,
  });

  final String title;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: blackColor),
        ),
        child: isLoading
            ? SizedBox(
                height: 25.r,
                width: 25.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: blackColor,
                ),
              )
            : Text(title),
      ),
    );
  }
}
