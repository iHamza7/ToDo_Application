import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_application/common/utils/constants.dart';
import 'package:sqflite_application/common/widgets/appstyle.dart';
import 'package:sqflite_application/common/widgets/reusable_text.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/expansion_tile.dart';
import '../controllers/xpansion_provider.dart';
import 'add_task.dart';
import 'todo_tiles.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConst.kBkDark,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AddTask()));
                            },
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
              Container(
                decoration: BoxDecoration(
                    color: AppConst.kLight,
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius))),
                child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        color: AppConst.kGreyLight,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConst.kRadius))),
                    controller: tabController,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    labelColor: AppConst.kBlueLight,
                    labelStyle:
                        appstyle(24, AppConst.kBkLight, FontWeight.w700),
                    unselectedLabelColor: AppConst.kLight,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: AppConst.kWidth * 0.5,
                          child: Center(
                            child: ReusableText(
                              text: "Pending",
                              style: appstyle(
                                  16, AppConst.kBkDark, FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(left: 30.w),
                          width: AppConst.kWidth * 0.5,
                          child: Center(
                            child: ReusableText(
                              text: "Completed",
                              style: appstyle(
                                  16, AppConst.kBkDark, FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: AppConst.kWidth,
                height: AppConst.kHeight * 0.3,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppConst.kRadius)),
                  child: TabBarView(controller: tabController, children: [
                    Container(
                      height: AppConst.kHeight * 0.3,
                      color: AppConst.kGreyBk,
                      child: ListView(
                        children: [
                          TodoTile(
                            start: "3:00",
                            end: "5:00",
                            switcher: Switch.adaptive(
                                value: true, onChanged: (value) {}),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: AppConst.kHeight * 0.3,
                      color: AppConst.kGreyBk,
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              XpansionTile(
                  text: "Tomorrow's Task",
                  text2: "Tomorrow's tasks are shown here",
                  onExpansionChanged: (bool expanded) {
                    ref
                        .watch(xpansionStateProvider.notifier)
                        .setStart(!expanded);
                  },
                  trailing: Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: ref.watch(xpansionStateProvider)
                          ? const Icon(AntDesign.circledown,
                              color: AppConst.kLight)
                          : const Icon(
                              AntDesign.clockcircleo,
                              color: AppConst.kBlueLight,
                            )),
                  children: [
                    TodoTile(
                      start: "3:00",
                      end: "5:00",
                      switcher:
                          Switch.adaptive(value: true, onChanged: (value) {}),
                    )
                  ]),
              const SizedBox(
                height: 20,
              ),
              XpansionTile(
                  text: DateTime.now()
                      .add(const Duration(days: 2))
                      .toString()
                      .substring(5, 10),
                  text2: "Day after Tomorrow's tasks",
                  onExpansionChanged: (bool expanded) {
                    ref
                        .watch(xpansionState0Provider.notifier)
                        .setStart(!expanded);
                  },
                  trailing: Padding(
                      padding: EdgeInsets.only(right: 12.0.w),
                      child: ref.watch(xpansionState0Provider)
                          ? const Icon(AntDesign.circledown,
                              color: AppConst.kLight)
                          : const Icon(
                              AntDesign.clockcircleo,
                              color: AppConst.kBlueLight,
                            )),
                  children: [
                    TodoTile(
                      start: "3:00",
                      end: "5:00",
                      switcher:
                          Switch.adaptive(value: true, onChanged: (value) {}),
                    )
                  ])
            ],
          ),
        )));
  }
}
