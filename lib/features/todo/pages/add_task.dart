import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/task_model.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/appstyle.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/custom_otline_btn.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

import '../controllers/dates/date_provider.dart';
import '../controllers/todo/todo_provider.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final scheduleDate = ref.watch(dateStateProvider);
    final startTime = ref.watch(startTimeStateProvider);
    final finishTime = ref.watch(finishTimeStateProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Add Title",
              controller: title,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: "Add Description",
              controller: description,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomOutlineButton(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 9, 1),
                      maxTime: DateTime(2024, 9, 1),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate == ""
                    ? "Set Date"
                    : scheduleDate.substring(0, 10)),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineButton(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: startTime == ""
                        ? "Start Time"
                        : startTime.substring(10, 16)),
                const SizedBox(
                  height: 20,
                ),
                CustomOutlineButton(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setFinish(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: finishTime == ""
                        ? "End Time"
                        : finishTime.substring(10, 16)),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomOutlineButton(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      description.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      startTime.isNotEmpty &&
                      finishTime.isNotEmpty) {
                    TaskModel taskModel = TaskModel(
                      title: title.text,
                      description: description.text,
                      isCompleted: 0,
                      startTime: startTime.substring(10, 16),
                      endTime: finishTime.substring(10, 16),
                      date: scheduleDate,
                      remind: 0,
                      repeat: "yes ",
                    );
                    ref.read(todoStateProvider.notifier).addItem(taskModel);
                    ref.read(dateStateProvider.notifier).setDate('');
                    ref.read(startTimeStateProvider.notifier).setStart('');
                    ref.read(finishTimeStateProvider.notifier).setFinish('');

                    Navigator.pop(context);
                  } else {
                    debugPrint('please enter');
                  }
                },
                width: AppConst.kWidth * 0.4,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: "Submit"),
          ],
        ),
      ),
    );
  }
}
