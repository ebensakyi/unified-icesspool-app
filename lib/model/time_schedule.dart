// // To parse this JSON data, do
// //
// //     final TimeSchedule = TimeScheduleFromJson(jsonString);

// import 'dart:convert';

// List<TimeSchedule> timeScheduleFromJson(String str) => List<TimeSchedule>.from(
//     json.decode(str).map((x) => TimeSchedule.fromJson(x)));

// String timeScheduleToJson(List<TimeSchedule> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class TimeSchedule {
//   TimeSchedule({
//     required this.id,
//     required this.time_schedule,
//     required this.start_time,
//     required this.end_time,
//   });

//   int id;
//   String? time_schedule;
//   String? end_time;
//   String? start_time;

//   factory TimeSchedule.fromJson(Map<String, dynamic> json) => TimeSchedule(
//         id: json["id"],
//         time_schedule: json["time_schedule"],
//         start_time: json["start_time"],
//         end_time: json["end_time"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "time_schedule": time_schedule,
//         "start_time": start_time,
//         "end_time": end_time,
//       };
// }
