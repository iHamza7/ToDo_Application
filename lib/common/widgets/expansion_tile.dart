import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ExpansionTile extends StatelessWidget {
  const ExpansionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConst.kBkLight,
          borderRadius: BorderRadius.all(Radius.circular(AppConst.kRadius))),
    );
  }
}
