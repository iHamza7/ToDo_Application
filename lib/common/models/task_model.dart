import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  int? id;
  String? title;
  String? description;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  String? remind;
  int? repeat;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.remind,
    this.repeat,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["isCompleted"],
        date: json["date"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        remind: json["remind"],
        repeat: json["repeat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "remind": remind,
        "repeat": repeat,
      };
}
