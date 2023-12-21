import 'package:flutter/material.dart';
import 'package:icesspool/themes/colors.dart';
import 'package:icesspool/widgets/sub-service-widget.dart';

class BioDigesterMainView extends StatelessWidget {
  BioDigesterMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bio-digester"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Container(
                child: Text("SERVICE YOUR BIODIGESTER TOILET"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SubServiceWidget(
                  activeBgColor: MyColors.SubServiceColor2,
                  inactiveBgColor: MyColors.DarkBlue,
                  activeTextColor: Colors.white,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Digester Emptying',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor2,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Soakaway Servicing',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor2,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Drainfield Servicing',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor1,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/vidmore.png",
                  size: 32,
                  title: 'Learn More',
                  subTitle: 'Read & watch videos',
                  onTap: null,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: Container(
                child: Text("BUILD A NEW BIO-DIGESTER TOILET"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SubServiceWidget(
                  activeBgColor: MyColors.SubServiceColor5,
                  inactiveBgColor: MyColors.DarkBlue,
                  activeTextColor: Colors.white,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Biodigester Only',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor5,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Biodigester With Seat',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor5,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/biodigester.png",
                  size: 32,
                  title: 'Standalone Toilet',
                  subTitle: 'Service or build',
                  onTap: null,
                ),
              ),
              Expanded(
                child: SubServiceWidget(
                  activeTextColor: Colors.white,
                  activeBgColor: MyColors.SubServiceColor1,
                  inactiveBgColor: MyColors.DarkBlue,
                  isAvailable: true,
                  path: "assets/images/vidmore.png",
                  size: 32,
                  title: 'Learn More',
                  subTitle: 'Read & watch videos',
                  onTap: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
