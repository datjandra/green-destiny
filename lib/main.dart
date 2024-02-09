import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Destiny',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double globalTemperature = 15.0; // Initial global temperature
  double winThreshold =
      10.0; // Player wins if global temperature is reduced below this threshold
  double loseThreshold =
      20.0; // Player loses if global temperature exceeds this threshold
  double globalSustainabilityIndex =
      100.0; // Initial global sustainability index
  double playerProbabilityPowerLevel = 1.0; // Initial probability power level
  double sustainabilityOveruseFactor =
      0.1; // Factor to adjust globalSustainabilityIndex when power overused
  List<Scenario> scenarios = [
    Scenario(
        name: 'Beach cleanup',
        temperatureImpact: -0.5,
        sustainabilityImpact: 0.1),
    Scenario(
        name: 'Recycling campaign',
        temperatureImpact: -0.3,
        sustainabilityImpact: 0.05),
    Scenario(
        name: 'Planting trees',
        temperatureImpact: -0.4,
        sustainabilityImpact: 0.08),
    // Add more scenarios here
  ];
  String currentScenario = ''; // Initial scenario

  void executeAction(bool alterProbability, String selectedScenario) {
    Scenario scenario = scenarios.firstWhere((s) => s.name == selectedScenario);

    // Execute action based on scenario and power level
    if (alterProbability) {
      double successProbability = min(playerProbabilityPowerLevel * 0.5,
          1.0); // Adjust the success probability
      if (Random().nextDouble() < successProbability) {
        adjustGlobalTemperature(
            scenario.temperatureImpact * playerProbabilityPowerLevel);
        updateGlobalSustainabilityIndex(
            scenario.sustainabilityImpact * playerProbabilityPowerLevel);
        // Increase playerProbabilityPowerLevel after every successful alteration
        playerProbabilityPowerLevel += 0.1;
      } else {
        print('Alteration failed!');
        // Add failure logic here
        adjustGlobalTemperature(scenario.temperatureImpact);
        // Altering probability is dangerous even if alteration failed
        updateGlobalSustainabilityIndex(
            scenario.sustainabilityImpact * playerProbabilityPowerLevel);
      }
    } else {
      print('Player chose not to alter probability.');
      adjustGlobalTemperature(scenario.temperatureImpact);
    }

    // Check for unintended consequence of power overuse
    if (globalSustainabilityIndex <= 0) {
      // If sustainability index is depleted, player loses
      print('Game over! Global sustainability index depleted.');
      // Add game over logic here
    }
    // Add additional actions here if needed
  }

  void adjustGlobalTemperature(double adjustment) {
    setState(() {
      globalTemperature += adjustment;
    });
  }

  void updateGlobalSustainabilityIndex(double impact) {
    setState(() {
      globalSustainabilityIndex +=
          impact - (sustainabilityOveruseFactor * playerProbabilityPowerLevel);
    });
  }

  void updateGlobalTemperature() {
    setState(() {
      globalTemperature +=
          Random().nextDouble() * 0.5 - 0.25; // Random fluctuation
    });
  }

  @override
  void initState() {
    super.initState();
    selectRandomScenario(); // Select a random scenario when the game page is initialized
  }

  void selectRandomScenario() {
    setState(() {
      currentScenario = scenarios[Random().nextInt(scenarios.length)].name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Sustainability Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: currentScenario,
              onChanged: (String? newValue) {
                setState(() {
                  currentScenario = newValue!;
                });
              },
              items:
                  scenarios.map<DropdownMenuItem<String>>((Scenario scenario) {
                return DropdownMenuItem<String>(
                  value: scenario.name,
                  child: Text(scenario.name),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Global Temperature: $globalTemperature',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Global Sustainability Index: $globalSustainabilityIndex',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                executeAction(true, currentScenario); // Alter probability
              },
              child: Text('Alter Probability'),
            ),
            ElevatedButton(
              onPressed: () {
                executeAction(false, currentScenario); // Do nothing
              },
              child: Text('Do Nothing'),
            ),
          ],
        ),
      ),
    );
  }
}

class Scenario {
  final String name;
  final double temperatureImpact;
  final double sustainabilityImpact;

  Scenario(
      {required this.name,
      required this.temperatureImpact,
      required this.sustainabilityImpact});
}
