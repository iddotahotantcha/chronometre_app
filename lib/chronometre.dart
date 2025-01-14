import 'package:chronometre_app/config.dart';
import 'package:flutter/material.dart';

class Chronometre extends StatefulWidget {
  const Chronometre({super.key});

  @override
  State<Chronometre> createState() => _ChronometreState();
}

class _ChronometreState extends State<Chronometre> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          color: appFirstColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight / 3.0,
              width: screenHeight / 3.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: appSecondColor,
                  width: 5.0,
                ),
                borderRadius: BorderRadius.circular(screenHeight / 4.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "00:00",
                        style: TextStyle(
                            color: appSecondColor,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: " 00",
                            style: TextStyle(
                              color: appSecondColor,
                              fontSize: 25.0,
                              fontWeight: FontWeight.normal,
                              textBaseline: TextBaseline.alphabetic,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight / 10.0,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.replay_outlined,
            color: appSecondColor,
            size: 30.0,
          ),
          Container(
            height: screenHeight / 15.0,
            width: screenHeight / 15.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: appSecondColor,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(screenHeight / 4.0),
            ),
            child: Icon(
              Icons.play_arrow,
              color: appSecondColor,
              size: 30.0,
            ),
          ),
          Icon(
            Icons.alarm_add,
            color: appSecondColor,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
