import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icesspool/contants.dart';
import 'package:icesspool/controllers/single_report_controller.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/small-button.dart';

class SingleReportView extends StatelessWidget {
  final controller = Get.put(SingleReportController());

  SingleReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Report")),
      body: ListView(
        children: [
          Card(
            elevation: 5,
            child: Container(
              height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image(
                  //   image: NetworkImage(Constants.AWS_S3_URL + controller.image.value),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: FadeInImage(
                                fit: BoxFit.cover,
                                height: 180,
                                width: 180,
                                image: NetworkImage(Constants.AWS_S3_URL +
                                    controller.image.value),
                                placeholder: AssetImage(
                                    "assets/images/photo_placeholder.png")),

                            //  Image.network(
                            //   height: 200,
                            //   fit: BoxFit.fitWidth,
                            //   Constants.AWS_S3_URL + controller.image.value,
                            //   loadingBuilder:
                            //       (context, child, loadingProgress) {
                            //     if (loadingProgress == null) return child;

                            //     return const Center(
                            //       child: CircularProgressIndicator(),
                            //     );
                            //     // You can use LinearProgressIndicator or CircularProgressIndicator instead
                            //   },
                            //   errorBuilder: (context, error, stackTrace) => Obx(
                            //     () => Text(""),
                            //   ),
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.community.value,
                            style: TextStyle(color: Colors.black, fontSize: 13),
                            softWrap: true,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Constants.REPORT_CATEGORY[
                                controller.reportCategoryId.value]["name"],
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                controller.createdAt.value,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Chip(
                                backgroundColor: controller.status == 0
                                    ? MyColors.Red
                                    : controller.status == 2
                                        ? MyColors.Red
                                        : MyColors.Red,
                                labelStyle: TextStyle(color: Colors.white),
                                label: Text(
                                  Constants.REPORT_STATUS[
                                      controller.status.value]["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.description.value,
                            style: TextStyle(
                                color: Colors.black54, wordSpacing: 9),
                            softWrap: true,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmallButton(
                          backgroundColor: MyColors.SecondaryColor,
                          label: "Delete",
                          onPressed: () {
                            controller.deleteReport(controller.id.value);
                          },
                          showLoading: false),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
