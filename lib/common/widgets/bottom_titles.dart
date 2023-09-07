import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/constants.dart';
import 'appstyle.dart';
import 'reusable_text.dart';

class BottomTitles extends StatelessWidget {
  final String text;
  final String text2;
  final Color? color;
  const BottomTitles(
      {super.key, required this.text, required this.text2, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                      //TODO: dynamic colors
                      color: AppConst.kLight,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppConst.kRadius))),
                );
              },
            ),
            const SizedBox(width: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    text: text,
                    style: appstyle(24, AppConst.kLight, FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ReusableText(
                    text: text2,
                    style: appstyle(12, AppConst.kLight, FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
