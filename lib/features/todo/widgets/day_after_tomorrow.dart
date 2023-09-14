import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/utils/constants.dart';
import '../../../common/widgets/expansion_tile.dart';
import '../controllers/todo/todo_provider.dart';
import '../controllers/xpansion_provider.dart';
import '../pages/todo_tiles.dart';

class DayAfterTomorrow extends ConsumerWidget {
  const DayAfterTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String dayAfterTomorrow =
        ref.read(todoStateProvider.notifier).getDayAfterTomorrow();
    var tomorrowTask = todos.where(
      (element) => element.date!.contains(dayAfterTomorrow),
    );
    return XpansionTile(
        text: DateTime.now()
            .add(const Duration(days: 2))
            .toString()
            .substring(5, 10),
        text2: "Day after Tomorrow's tasks",
        onExpansionChanged: (bool expanded) {
          ref.watch(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: ref.watch(xpansionStateProvider)
                ? const Icon(AntDesign.circledown, color: AppConst.kLight)
                : const Icon(
                    AntDesign.clockcircleo,
                    color: AppConst.kBlueLight,
                  )),
        children: [
          for (final todos in tomorrowTask)
            TodoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(todos.id ?? 0);
              },
              editWidget: GestureDetector(
                onTap: () {},
                child: const Icon(MaterialCommunityIcons.circle_edit_outline),
              ),
              color: color,
              title: todos.title,
              description: todos.description,
              start: todos.startTime,
              end: todos.endTime,
              switcher: const SizedBox.shrink(),
            )
        ]);
  }
}