import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';
import '../pages/todo_tiles.dart';

class TodyList extends ConsumerWidget {
  const TodyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<TaskModel> listData = ref.watch(todoStateProvider);
    String today = ref.read(todoStateProvider.notifier).getToday();
    final todayList = listData
        .where((element) =>
            element.isCompleted == 0 && element.date!.contains(today))
        .toList();
    return ListView.builder(
      itemCount: todayList.length,
      itemBuilder: (context, int index) {
        final data = todayList[index];
        bool isCompleted = ref.read(todoStateProvider.notifier).getStatus(data);
        dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
        return TodoTile(
          color: color,
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          switcher: Switch(value: isCompleted, onChanged: (value) {}),
        );
      },
    );
  }
}
