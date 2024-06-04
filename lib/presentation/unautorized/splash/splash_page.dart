import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:test_to_do/app/palette.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Task To Do',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 56,
                color: orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 150.r,
              width: 150.r,
              child: Lottie.asset('assets/1717269223149.json'),
            ),
          ],
        ),
      );
}
