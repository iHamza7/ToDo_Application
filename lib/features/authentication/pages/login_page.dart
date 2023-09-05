import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';
import '../../../common/widgets/custom_otline_btn.dart';

import '../../../common/widgets/appstyle.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.kBkDark,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Image.asset('assets/images/todo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 16),
              child: ReusableText(
                text: "Please enter your phone number",
                style: appstyle(17, AppConst.kLight, FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(),
            const SizedBox(
              height: 20,
            ),
            CustomOutlineButton(
                width: AppConst.kWidth * 0.8,
                height: AppConst.kHeight * 0.07,
                color: AppConst.kBkDark,
                color2: AppConst.kLight,
                text: "Send Code"),
          ],
        ),
      )),
    );
  }
}
