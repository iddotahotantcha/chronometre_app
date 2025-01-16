import 'dart:async';
import 'package:flutter/material.dart';

import 'config.dart';

class Chronometre extends StatefulWidget {
  const Chronometre({super.key});

  @override
  State<Chronometre> createState() => _ChronometreState();
}

class _ChronometreState extends State<Chronometre> {
  bool isRunning = false;
  int elapsedMilliseconds = 0; // Temps écoulé
  DateTime? startTime; // Heure de début
  Timer? timer; 
  List<String> laps = []; 

  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      startTime = DateTime.now().subtract(Duration(milliseconds: elapsedMilliseconds));
      timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        setState(() {
          elapsedMilliseconds = DateTime.now().difference(startTime!).inMilliseconds;
        });
      });
    }
  }

  void stopTimer() {
    if (isRunning) {
      timer?.cancel();
      isRunning = false;
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      elapsedMilliseconds = 0;
      laps.clear();
    });
  }

  void addLap() {
    String lapTime = formatTime(elapsedMilliseconds);
    setState(() {
      laps.add(lapTime);
    });
  }

  String formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    int remainingMilliseconds = (milliseconds % 1000) ~/ 10;

    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')} ${remainingMilliseconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
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
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: formatTime(elapsedMilliseconds)
                        .split(' ')[0],
                    style: TextStyle(
                      color: appSecondColor,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " ${formatTime(elapsedMilliseconds).split(' ')[1]}",
                        style: TextStyle(
                          color: appSecondColor,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight / 4,
              width: screenWidth,
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Lap ${index + 1}",
                      style: TextStyle(color: appSecondColor),
                    ),
                    trailing: Text(
                      laps[index],
                      style: TextStyle(color: appSecondColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: resetTimer,
            icon:
                Icon(Icons.replay_outlined, color: appSecondColor, size: 30.0),
          ),
          InkWell(
            onTap: isRunning ? stopTimer : startTimer,
            child: Container(
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
                isRunning ? Icons.pause : Icons.play_arrow,
                color: appSecondColor,
                size: 30.0,
              ),
            ),
          ),
          IconButton(
            onPressed: addLap,
            icon: Icon(Icons.flag, color: appSecondColor, size: 30.0),
          ),
        ],
      ),
    );
  }
}
