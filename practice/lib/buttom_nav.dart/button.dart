import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigation(),
    ),
  );
}

enum CardType { red, blue }

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool isTap = true;
  int redCount = 0;
  int blueCount = 0;

  void handleTap(CardType type) {
    setState(() {
      if (type == CardType.red) {
        redCount++;
      } else {
        blueCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isTap
          ? ColorTapScreen(
              redCount: redCount,
              blueCount: blueCount,
              onScreenAction: handleTap,
            )
          : StatisticScreen(redCount: redCount, blueCount: blueCount),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: isTap ? 0 : 1,
        onTap: (index) {
          setState(() {
            isTap = (index == 0);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.touch_app), label: 'Tap'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        ],
      ),
    );
  }
}

class ColorTapScreen extends StatelessWidget {
  final int redCount;
  final int blueCount;

  // WHY: It must be a function to 'delay' execution; if it weren't, the code
  // would run immediately during build instead of waiting for a user tap.
  // WHAT: It’s a 'Closure'—it acts as a "memory container" that holds onto
  // the specific data (Red/Blue) until the moment the function is triggered.
  final Function(CardType) onScreenAction;

  const ColorTapScreen({
    super.key,
    required this.redCount,
    required this.blueCount,
    required this.onScreenAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tap the Colors")),
      body: Column(
        children: [
          ColorTap(
            type: CardType.red,
            currentCount: redCount,
            onButtonPressed: () => onScreenAction(CardType.red),
          ),
          ColorTap(
            type: CardType.blue,
            currentCount: blueCount,
            onButtonPressed: () => onScreenAction(CardType.blue),
          ),
        ],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int currentCount;
  final VoidCallback onButtonPressed;

  const ColorTap({
    super.key,
    required this.type,
    required this.currentCount,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: type == CardType.red ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $currentCount',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticScreen extends StatelessWidget {
  final int redCount;
  final int blueCount;

  const StatisticScreen({
    super.key,
    required this.redCount,
    required this.blueCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistic")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Red Total: $redCount',
              style: const TextStyle(fontSize: 30, color: Colors.red),
            ),
            Text(
              'Blue Total: $blueCount',
              style: const TextStyle(fontSize: 30, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
