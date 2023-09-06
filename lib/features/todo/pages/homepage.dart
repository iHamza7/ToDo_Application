import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:sqflite_application/common/widgets/appstyle.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../common/widgets/custom_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(85),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReusableText(
                          text: "Dashboard",
                          style: appstyle(18, AppConst.kLight, FontWeight.bold),
                        ),
                        Container(
                          width: 25.w,
                          height: 25.h,
                          decoration: const BoxDecoration(
                            color: AppConst.kLight,
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.add,
                              color: AppConst.kBkDark,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hintText: "Search",
                    controller: search,
                    suffixIcon: const Icon(FontAwesome.sliders),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(14.h),
                      child: GestureDetector(
                        onTap: null,
                        child: const Icon(
                          AntDesign.search1,
                          color: AppConst.kGreyLight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              )),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Icon(
                    FontAwesome.tasks,
                    color: AppConst.kLight,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  ReusableText(
                      text: "Today's Task",
                      style: appstyle(18, AppConst.kLight, FontWeight.bold))
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        )));
  }
}
