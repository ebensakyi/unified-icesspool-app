import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Widget question;
  final Widget yesBtn;
  final Widget noBtn;

  const QuestionCard(
      {super.key,
      required this.question,
      required this.yesBtn,
      required this.noBtn});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: 100,
      color: Colors.amber,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: question,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: yesBtn,
                ),
              ),
              noBtn
            ]),
          )
        ],
      ),
    );
  }
}
