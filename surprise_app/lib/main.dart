import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Confetti Demo',
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        isPlaying = controller.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          backgroundColor: const Color.fromRGBO(50, 50, 50, 1),
          appBar: AppBar(
            title: const Text('Happy Birthday Jeremy!'),
            centerTitle: true,
            backgroundColor: const Color.fromRGBO(56, 182, 17, 1),
          ),
          body: Center(
            child: ElevatedButton(
              child: Text(
                isPlaying ? 'Stop the Party :(' : 'Click & Celebrate!',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(56, 182, 17, 1),
                shadowColor: Colors.white,
              ),
              onPressed: () {
                if (isPlaying) {
                  controller.stop();
                } else {
                  controller.play();
                }
              },
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          // blastDirection: pi / 2,
          minBlastForce: 20,
          maxBlastForce: 100,
          numberOfParticles: 20,
          emissionFrequency: .08,
          gravity: 1,
        ),
      ],
    );
  }
}
