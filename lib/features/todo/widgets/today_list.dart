import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../common/models/task_model.dart';
import '../controllers/todo/todo_provider.dart';
import '../pages/todo_tiles.dart';
import '../pages/update_task.dart';

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
          delete: () {
            ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
          },
          editWidget: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateTask(
                            id: data.id!,
                          )));
            },
            child: const Icon(MaterialCommunityIcons.circle_edit_outline),
          ),
          color: color,
          title: data.title,
          description: data.description,
          start: data.startTime,
          end: data.endTime,
          switcher: Switch(
              value: isCompleted,
              onChanged: (value) {
                ref.read(todoStateProvider.notifier).markAsCompleted(
                    data.id ?? 0,
                    data.title!,
                    data.description!,
                    1,
                    data.date!,
                    data.startTime!,
                    data.endTime!);
              }),
        );
      },
    );
  }
}
