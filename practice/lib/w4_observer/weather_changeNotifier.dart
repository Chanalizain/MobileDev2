import 'package:flutter/material.dart';

// 1. The Subject: Inherit from ChangeNotifier
class WeatherStation extends ChangeNotifier {
  int _temperature = 0;

  int get temperature => _temperature;

  // Instead of manual notifyListener() with a loop,
  // we use the built-in notifyListeners()
  void setTemperature(int newTemperature) {
    if (newTemperature != _temperature) {
      _temperature = newTemperature;

      // This alerts all ListenableBuilders currently watching this station
      notifyListeners();
    }
  }
}

void main() {
  // Create a single instance (the state)
  final myStation = WeatherStation();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 2. The Listener: ListenableBuilder
              ListenableBuilder(
                listenable: myStation,
                builder: (context, child) {
                  // This specific block re-builds whenever notifyListeners() is called
                  return Text(
                    "Current Temp: ${myStation.temperature}°C",
                    style: const TextStyle(fontSize: 24),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedErrorButton(station: myStation),
            ],
          ),
        ),
      ),
    ),
  );
}

// Button component that modifies the state
class ElevatedErrorButton extends StatelessWidget {
  final WeatherStation station;
  const ElevatedErrorButton({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => station.setTemperature(40),
      child: const Text("Set to 40°C"),
    );
  }
}
