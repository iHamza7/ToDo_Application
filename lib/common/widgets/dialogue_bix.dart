import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';

import '../utils/constants.dart';
import 'appstyle.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ReusableText(
              text: message,
              style: appstyle(18, AppConst.kLight, FontWeight.w600)),
          contentPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  btnText ?? 'Ok',
                  style: appstyle(18, AppConst.kGreyLight, FontWeight.w500),
                ))
          ],
        );
      });
}
