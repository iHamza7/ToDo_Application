import 'package:flutter/material.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:sqflite_application/common/widgets/appstyle.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ReusableText(
          text: 'Todo with riverpod',
          style: appstyle(26, AppConst.kBlueLight, FontWeight.bold),
        ),
      ),
    );
  }
}
