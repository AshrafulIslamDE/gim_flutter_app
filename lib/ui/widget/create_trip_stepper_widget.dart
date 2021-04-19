import 'package:flutter/material.dart';

class TripStepper extends StatelessWidget {
  final noOfSteps;
  final int currentStep;
  final double radius;
  final Color borderColor;
  final Color dividerColor;
  final Color stepRemFillColor;
  final Color stepFinalFillColor;

  TripStepper(
      {this.currentStep,
      this.radius = 12.0,
      this.noOfSteps = 3,
      this.stepRemFillColor = Colors.white,
      this.stepFinalFillColor = Colors.yellow,
      this.borderColor = Colors.yellow,
      this.dividerColor = Colors.yellow});

  @override
  Widget build(BuildContext context) {
    return currentStep == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getStepper(),
              ),
            ),
          );
  }

  List<Widget> getStepper() {
    List<Widget> widgets = List();
    for (int index = 0; index < noOfSteps; index++) {
      widgets.add(circleWidget(
          index + 1 <= currentStep ? stepFinalFillColor : stepRemFillColor));
      if (index + 1 != noOfSteps) {
        widgets.add(lineWidget());
      }
    }
    return widgets;
  }

  Widget circleWidget(Color fillColor) {
    return Container(
      width: radius,
      height: radius,
      decoration: new BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
    );
  }

  Widget lineWidget() {
    return Expanded(
        child: Divider(
      color: dividerColor,
      thickness: 1.0,
    ));
  }
}
