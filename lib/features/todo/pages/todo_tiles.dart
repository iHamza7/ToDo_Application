import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/appstyle.dart';
import '../../../common/widgets/reusable_text.dart';

class TodoTile extends StatelessWidget {
  final Color? color;
  final String? title;
  final String? description;

  const TodoTile({super.key, this.color, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            width: AppConst.kWidth,
            decoration: BoxDecoration(
                color: AppConst.kGreyLight,
                borderRadius:
                    BorderRadius.all(Radius.circular(AppConst.kRadius))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 5,
                      decoration: BoxDecoration(
                          //TODO: dynamic colors
                          color: color ?? AppConst.kRed,
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppConst.kRadius))),
                    ),
                    const SizedBox(width: 15),
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: SizedBox(
                        width: AppConst.kWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: title ?? "Title of TODO",
                              style: appstyle(
                                  18, AppConst.kLight, FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            ReusableText(
                              text: description ?? "Description of TODO",
                              style: appstyle(
                                  12, AppConst.kLight, FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: AppConst.kWidth * 0.3,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.3,
                                        color: AppConst.kGreyDK,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(AppConst.kRadius))),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
