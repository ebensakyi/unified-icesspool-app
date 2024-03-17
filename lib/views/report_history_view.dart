// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import 'package:icesspool/controllers/home_controller.dart';
// import 'package:icesspool/routes/app_pages.dart';
// import 'package:icesspool/themes/colors.dart';

// class ReportHistoryView extends GetView<HomeController> {
//   final controller = Get.put(HomeController());

//   ReportHistoryView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Obx(
//       () => controller.isLoading.value
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : controller.reports.length == 0
//               ? Center(
//                   child: Text("No history"),
//                 )
//               : ListView.builder(
//                   itemCount: controller.reports.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Text(
//                               controller.reports[index].description,
//                               style: TextStyle(fontSize: 13),
//                               softWrap: true,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           subtitle: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Padding(
//                                 //   padding: const EdgeInsets.all(4.0),
//                                 //   child: Text(
//                                 //     controller.reports[index].community,
//                                 //     style: TextStyle(fontSize: 13),
//                                 //     softWrap: true,
//                                 //     maxLines: 1,
//                                 //     overflow: TextOverflow.ellipsis,
//                                 //   ),
//                                 // ),
//                                 Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         " ${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(controller.reports[index].createdAt.toIso8601String()))} ",
//                                         style: TextStyle(fontSize: 10),
//                                       ),
//                                       // controller.reports[index].status == 0
//                                       //     ? Padding(
//                                       //         padding: const EdgeInsets.all(8.0),
//                                       //         child: Chip(
//                                       //           backgroundColor: Color.fromARGB(
//                                       //               255, 250, 69, 56),
//                                       //           labelStyle:
//                                       //               TextStyle(color: Colors.white),
//                                       //           label: Text(
//                                       //             "Pending",
//                                       //             style: TextStyle(fontSize: 10),
//                                       //           ),
//                                       //         ),
//                                       //       )
//                                       //     : controller.reports[index].status == 1
//                                       //         ? Padding(
//                                       //             padding:
//                                       //                 const EdgeInsets.all(5.0),
//                                       //             child: Chip(
//                                       //               backgroundColor: Color.fromARGB(
//                                       //                   255, 50, 159, 53),
//                                       //               labelStyle: TextStyle(
//                                       //                   color: Colors.white),
//                                       //               label: Text(
//                                       //                 "Completed",
//                                       //                 style:
//                                       //                     TextStyle(fontSize: 10),
//                                       //               ),
//                                       //             ),
//                                       //           )
//                                       //         : Padding(
//                                       //             padding:
//                                       //                 const EdgeInsets.all(5.0),
//                                       //             child: Chip(
//                                       //               backgroundColor: Color.fromARGB(
//                                       //                   255, 216, 195, 6),
//                                       //               labelStyle: TextStyle(
//                                       //                   color: Colors.white),
//                                       //               label: Text(
//                                       //                 "In progress",
//                                       //                 style:
//                                       //                     TextStyle(fontSize: 10),
//                                       //               ),
//                                       //             ),
//                                       //           ),
//                                     ]),
//                               ],
//                             ),
//                           ),
//                           leading: CircleAvatar(
//                             backgroundColor:
//                                 controller.reports[index].status == 0
//                                     ? MyColors.Red
//                                     : controller.reports[index].status == 2
//                                         ? MyColors.Red
//                                         : MyColors.Red,
//                             child: Text(
//                                 controller.reports[index].community[0]
//                                     .toUpperCase(),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                     color: Colors.white)),
//                           ),

//                           // leading: Image.network(controller.reports[index].image),
//                           onTap: () {
//                             var data = {
//                               "id": controller.reports[index].id,
//                               "community": controller.reports[index].community,
//                               "description":
//                                   controller.reports[index].description,
//                               "image": controller.reports[index].image,
//                               "longitude": controller.reports[index].longitude,
//                               "latitude": controller.reports[index].latitude,
//                               "status": controller.reports[index].status,
//                               "statusMessage": controller
//                                   .reports[index].statusMessage
//                                   .toString(),
//                               "reportCategoryId":
//                                   controller.reports[index].reportCategoryId,
//                               "createdAt":
//                                   " ${DateFormat('dd MMM yyyy hh:mm a').format(DateTime.parse(controller.reports[index].createdAt.toIso8601String()))} "
//                             };
//                             // inspect(data);
//                             //   () => SingleReportView(),
//                             //   arguments: true,
//                             // );
//                             Get.toNamed(Routes.SINGLE_REPORT, arguments: data);
//                           }),
//                     );
//                   }),
//     ));
//   }
// }
