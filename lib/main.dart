import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

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

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double minRadius = 15.0; // Set min radius value
  final double maxRadius = 30.0; // Set max radius value

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
        name: 'Recycling campaign',
        temperatureImpact: -0.3,
        sustainabilityImpact: 0.05),
    Scenario(
        name: 'Planting trees',
        temperatureImpact: -0.4,
        sustainabilityImpact: 0.08),
    Scenario(
      name: 'Renewable Energy Investment',
      temperatureImpact: -0.6, // Moderate impact on reducing temperature
      sustainabilityImpact:
          0.2, // Significant positive impact on sustainability
    ),
    Scenario(
      name: 'Community Garden Project',
      temperatureImpact: -0.5, // Moderate impact on reducing temperature
      sustainabilityImpact: 0.12, // Moderate positive impact on sustainability
    ),
    Scenario(
      name: 'Carbon Capture Technology Implementation',
      temperatureImpact:
          -0.9, // Complex feat with high impact on reducing temperature
      sustainabilityImpact:
          0.25, // Significant positive impact on sustainability
    ),
    Scenario(
      name: 'Government Policy on Carbon Emissions',
      temperatureImpact:
          -0.7, // Complex feat with moderate impact on reducing temperature
      sustainabilityImpact:
          0.3, // Significant positive impact on sustainability
    ),
    Scenario(
      name: 'Burning fossil fuels',
      temperatureImpact: 0.2, // slightly raise temperature
      sustainabilityImpact: -0.1, // slightly reduce sustainability
    ),
    Scenario(
      name: 'Deforestation',
      temperatureImpact: 0.3, // slightly raise temperature
      sustainabilityImpact: -0.15, // slightly reduce sustainability
    ),
    Scenario(
      name: 'Industrial pollution',
      temperatureImpact: 0.15, // slightly raise temperature
      sustainabilityImpact: -0.08, // slightly reduce sustainability
    ),
    Scenario(
      name: 'Single-use Plastic Usage',
      temperatureImpact: 0.1, // Increase global temperature slightly
      sustainabilityImpact: -0.05, // Reduce sustainability slightly
    ),
    Scenario(
      name: 'Landfill Expansion',
      temperatureImpact: 0.2, // Increase global temperature slightly
      sustainabilityImpact: -0.08, // Reduce sustainability slightly
    ),
    Scenario(
      name: 'Excessive Water Consumption',
      temperatureImpact: 0.15, // Increase global temperature slightly
      sustainabilityImpact: -0.06, // Reduce sustainability slightly
    ),
    Scenario(
      name: 'Mass Deforestation',
      temperatureImpact: 0.5, // Increase global temperature moderately
      sustainabilityImpact: -0.2, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Large-scale Industrial Emissions',
      temperatureImpact: 0.6, // Increase global temperature moderately
      sustainabilityImpact: -0.25, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Expansion of Coal Mining',
      temperatureImpact: 0.7, // Increase global temperature moderately
      sustainabilityImpact: -0.3, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Oil Spill Pollution',
      temperatureImpact: 0.4, // Increase global temperature moderately
      sustainabilityImpact: -0.18, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Urban Sprawl',
      temperatureImpact: 0.3, // Increase global temperature moderately
      sustainabilityImpact: -0.15, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Intensive Livestock Farming',
      temperatureImpact: 0.6, // Increase global temperature moderately
      sustainabilityImpact: -0.28, // Moderate negative impact on sustainability
    ),
    Scenario(
      name: 'Expansion of Oil Drilling',
      temperatureImpact: 0.8, // Increase global temperature signficantly
      sustainabilityImpact: -0.35, // Decrease sustainability significantly
    ),
    Scenario(
      name: 'Deforestation for Agriculture',
      temperatureImpact: 0.9, // Increase global temperature signficantly
      sustainabilityImpact: -0.4, // Decrease sustainability significantly
    ),
    Scenario(
      name: 'Increased Urbanization',
      temperatureImpact: 0.7, // Increaes global temperature moderately
      sustainabilityImpact: -0.32, // Decrease sustainability significantly
    ),
    Scenario(
      name: 'Expansion of Cement Production',
      temperatureImpact: 0.75, // Increase global temperature signficantly
      sustainabilityImpact: -0.36, // Decrease sustainability significantly
    ),
    Scenario(
      name: 'Industrial Chemical Waste Dumping',
      temperatureImpact: 0.85, // Increase global temperature signficantly
      sustainabilityImpact: -0.38, // Decrease sustainability significantly
    )
  ];
  String currentScenario = ''; // Initial scenario
  bool gameEnded = false; // Flag to track game state

  void executeAction(
      bool alterProbability, String selectedScenario, int direction) {
    if (gameEnded) {
      restartGame();
    }

    _controller.reset(); // Reset the animation
    _controller.forward(); // Start the animation again

    Scenario scenario = scenarios.firstWhere((s) => s.name == selectedScenario);

    // Execute action based on scenario and power level
    if (alterProbability) {
      sustainabilityOveruseFactor += 0.1;
      double successProbability = min(playerProbabilityPowerLevel * 0.5,
          1.0); // Adjust the success probability
      if (Random().nextDouble() < successProbability) {
        adjustGlobalTemperature(scenario.temperatureImpact *
            playerProbabilityPowerLevel *
            direction);
        updateGlobalSustainabilityIndex(scenario.sustainabilityImpact *
            playerProbabilityPowerLevel *
            direction);
        // Increase playerProbabilityPowerLevel after every successful alteration
        playerProbabilityPowerLevel += 0.1;
      } else {
        print('Alteration failed!');
        // Same logic as do nothing
        adjustGlobalTemperature(scenario.temperatureImpact);
        updateGlobalSustainabilityIndex(scenario.sustainabilityImpact);
      }
    } else {
      print('Player chose not to alter probability.');
      adjustGlobalTemperature(scenario.temperatureImpact);
      updateGlobalSustainabilityIndex(scenario.sustainabilityImpact);
    }

    // Check win/loss conditions
    if (globalTemperature <= winThreshold) {
      print('Congratulations! You have won the game!');
      // Add win logic here
      endGame(true); // Player wins
    } else if (globalTemperature >= loseThreshold) {
      print('Game over! Global temperature exceeded the threshold.');
      // Add loss logic here
      endGame(false); // Player loses
    }

    // Check for unintended consequence of power overuse
    if (globalSustainabilityIndex <= 0) {
      // If sustainability index is depleted, player loses
      print('Game over! Global sustainability index depleted.');
      // Add game over logic here
      endGame(false); // Player loses due to power overuse
    }

    // Add additional actions here if needed
    selectRandomScenario();
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

  void endGame(bool win) {
    setState(() {
      gameEnded = true;
    });
    // Show win/loss ending screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(win
              ? 'Congratulations! The world is at peace.'
              : 'Game Over! The world is in chaos.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                restartGame(); // Restart the game
                Navigator.of(context).pop();
              },
              child: Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selectRandomScenario(); // Select a random scenario when the game page is initialized

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().whenComplete(() {
      _controller.reverse(); // Reverse animation after 1 second
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void restartGame() {
    setState(() {
      globalTemperature = 15.0; // Reset global temperature
      globalSustainabilityIndex = 100.0; // Reset global sustainability index
      playerProbabilityPowerLevel = 1.0; // Reset probability power level
      sustainabilityOveruseFactor = 0.1;
      gameEnded = false; // Reset game state
    });
    selectRandomScenario(); // Select a new random scenario
  }

  void selectRandomScenario() {
    setState(() {
      currentScenario = scenarios[Random().nextInt(scenarios.length)].name;
    });
  }

  Color determineGlobalTemperatureIndexColor(double value) {
    if (value <= 12) {
      return Colors.green;
    } else if (value >= 18) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  Color determineGlobalSustainabilityIndexColor(double value) {
    if (value <= 20) {
      return Colors.red;
    } else if (value >= 80) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Green Destiny'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'You have the awesome power to alter probability. '
                'You can boost or weaken impact of different scenarios '
                'that affect global temperature positively and negatively. '
                'Be careful, overusing your power will decrease sustainability and cause chaos.',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Scenario: $currentScenario',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Tooltip(
                  message:
                      'Boost or weaken scenarios to reduce or increase global temperature', // Tooltip message
                  child: Text(
                    'Global Temperature:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    height:
                        8), // Add some space between the text and the progress bar
                LinearProgressIndicator(
                  value: globalTemperature / 20,
                  backgroundColor:
                      Colors.grey[300], // Background color of the progress bar
                  valueColor: AlwaysStoppedAnimation<Color>(
                      determineGlobalTemperatureIndexColor(
                          globalTemperature)), // Color of the progress bar
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Tooltip(
                  message:
                      'Overusing your power reduces sustainability', // Tooltip message
                  child: Text(
                    'Global Sustainability Index:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    height:
                        8), // Add some space between the text and the progress bar
                LinearProgressIndicator(
                  value: globalSustainabilityIndex / 100,
                  backgroundColor:
                      Colors.grey[300], // Background color of the progress bar
                  valueColor: AlwaysStoppedAnimation<Color>(
                      determineGlobalSustainabilityIndexColor(
                          globalSustainabilityIndex)), // Color of the progress bar
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Tooltip(
                  message: 'Your power increases with usage', // Tooltip message
                  child: Text(
                    'Probability Power Level:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                    height:
                        8), // Add some space between the text and the progress bar
                LinearProgressIndicator(
                  value: playerProbabilityPowerLevel / 5,
                  backgroundColor:
                      Colors.grey[300], // Background color of the progress bar
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green), // Color of the progress bar
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Adjust the spacing between buttons
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // Adjust the horizontal spacing
                    child: ElevatedButton(
                      onPressed: () {
                        executeAction(true, currentScenario, 1);
                      },
                      child: Text('Boost'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // Adjust the horizontal spacing
                    child: ElevatedButton(
                      onPressed: () {
                        executeAction(true, currentScenario, -1);
                      },
                      child: Text('Weaken'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.0), // Adjust the horizontal spacing
                    child: ElevatedButton(
                      onPressed: () {
                        executeAction(false, currentScenario, 0);
                      },
                      child: Text('Nothing'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 20), // Adjust the vertical padding as needed
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: Size(maxRadius,
                        maxRadius), // Size of the custom graphical object
                    painter: TemporalShiftPainter(_animation.value,
                        minRadius: minRadius, maxRadius: maxRadius),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                restartGame();
              },
              child: Text('Restart'),
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

class TemporalShiftPainter extends CustomPainter {
  final double animationValue;
  final double minRadius;
  final double maxRadius;

  TemporalShiftPainter(this.animationValue,
      {required this.minRadius, required this.maxRadius});

  @override
  void paint(Canvas canvas, Size size) {
    double radius;
    if (animationValue < 0.5) {
      radius = lerpDouble(minRadius, maxRadius, animationValue * 2)!;
    } else {
      radius = lerpDouble(maxRadius, minRadius, (animationValue - 0.5) * 2)!;
    }

    final Paint paint = Paint()..color = Colors.green;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
