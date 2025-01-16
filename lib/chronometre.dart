import 'dart:async';
import 'package:flutter/material.dart';

import 'config.dart';

class Chronometre extends StatefulWidget {
  const Chronometre({super.key});

  @override
  State<Chronometre> createState() => _ChronometreState();
}

class _ChronometreState extends State<Chronometre> {
  bool isRunning = false; // Indique si le chronomètre est en cours d'exécution
  int milliseconds = 0; // Temps écoulé en millisecondes
  Timer? timer; // Timer pour la mise à jour du temps
  List<String> laps = []; // Liste des tours enregistrés

  // Démarre le chronomètre
  void startTimer() {
    if (!isRunning) {
      isRunning = true;
      timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        setState(() {
          milliseconds += 10;
        });
      });
    }
  }

  // Arrête le chronomètre
  void stopTimer() {
    if (isRunning) {
      timer?.cancel();
      isRunning = false;
    }
  }

  // Réinitialise le chronomètre et les laps
  void resetTimer() {
    stopTimer();
    setState(() {
      milliseconds = 0;
      laps.clear();
    });
  }

  // Ajoute un lap
  void addLap() {
    String lapTime = formatTime(milliseconds);
    setState(() {
      laps.add(lapTime);
    });
  }

  // Convertit le temps en une chaîne formatée
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
            // Cercle contenant le chronomètre
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
                    text: formatTime(milliseconds)
                        .split(' ')[0], // Minutes et secondes
                    style: TextStyle(
                      color: appSecondColor,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " ${formatTime(milliseconds).split(' ')[1]}", // Millisecondes
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
            Container(
              height: screenHeight/4,
              width: screenWidth,
              child: Expanded(
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
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Bouton de réinitialisation
          IconButton(
            onPressed: resetTimer,
            icon:
                Icon(Icons.replay_outlined, color: appSecondColor, size: 30.0),
          ),
          // Bouton de démarrage/arrêt
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
          // Bouton pour ajouter un lap
          IconButton(
            onPressed: addLap,
            icon: Icon(Icons.flag, color: appSecondColor, size: 30.0),
          ),
        ],
      ),
    );
  }
}
