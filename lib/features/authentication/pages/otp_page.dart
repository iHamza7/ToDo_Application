import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';
import 'package:pinput/pinput.dart';

import '../../../common/widgets/appstyle.dart';

class OtpPage extends StatelessWidget {
  final String smsCodeId;
  final String phone;
  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.kBkDark,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppConst.kHeight * 0.12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset("assets/images/todo.png",
                width: AppConst.kWidth * 0.5),
          ),
          const SizedBox(
            height: 26,
          ),
          ReusableText(
            text: "Enter Your OTP Code",
            style: appstyle(18, AppConst.kLight, FontWeight.bold),
          ),
          const SizedBox(
            height: 26,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Pinput(
              length: 6,
              onChanged: (value) {
                if (value.length == 6) {}
              },
              onSubmitted: (value) {
                if (value.length == 6) {}
              },
            ),
          )
        ],
      )),
    );
  }
}
