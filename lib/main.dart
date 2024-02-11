import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'scenarios.dart';
import 'painter.dart';
import 'splash.dart';

// Define an enum with the desired options
enum Difficulty {
  Normal,
  Harder,
  Hardest,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Callback function to navigate to the GamePage
  void navigateToGamePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => GamePage(scenarios: scenarios)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Destiny',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(
          navigateToGamePage), // Pass the callback function to SplashScreen,
    );
  }
}

class GamePage extends StatefulWidget {
  final List<Scenario> scenarios;

  GamePage({required this.scenarios});

  @override
  _GamePageState createState() => _GamePageState(scenarios: scenarios);
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double minRadius = 10.0; // Set min radius value
  final double maxRadius = 20.0; // Set max radius value

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

  String currentScenario = ''; // Initial scenario
  bool gameEnded = false; // Flag to track game state
  bool clockwiseDir = true;
  final List<Scenario> scenarios; // Add scenarios as a class variable

  _GamePageState(
      {required this.scenarios}); // Constructor with scenarios argument

  bool clockwiseRotation() {
    return clockwiseDir;
  }

  void executeAction(
      bool alterProbability, String selectedScenario, int direction) {
    if (gameEnded) {
      restartGame();
    }

    Scenario scenario = scenarios.firstWhere((s) => s.name == selectedScenario);

    // Execute action based on scenario and power level
    if (alterProbability) {
      if (direction > 0) {
        clockwiseDir = true;
      } else if (direction < 0) {
        clockwiseDir = false;
      }

      _controller.reset(); // Reset the animation
      _controller.forward(); // Start the animation again

      sustainabilityOveruseFactor += 0.1;
      double successProbability =
          calculateSuccessProbability(scenario, playerProbabilityPowerLevel);
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

  double calculateSuccessProbability(
      Scenario scenario, double playerProbabilityPowerLevel) {
    // Adjust success probability based on impacts
    double temperatureFactor = 1 - scenario.temperatureImpact.abs();
    double sustainabilityFactor = 1 - scenario.sustainabilityImpact.abs();

    // Calculate combined factor
    double combinedFactor = playerProbabilityPowerLevel *
        (temperatureFactor + sustainabilityFactor) /
        2;

    // Calculate success probability
    double successProbability = min(combinedFactor, 1.0);
    return successProbability;
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

  Future<Image> _getImageAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    return Image.memory(bytes);
  }

  void endGame(bool win) {
    setState(() {
      gameEnded = true;
    });
    // Show win/loss ending screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String dialogImage =
            (win ? 'assets/images/peace.png' : 'assets/images/chaos.png');
        String dialogText = (win
            ? 'Congratulations! The world is at peace.'
            : 'Game over! The world is in chaos.');
        return FutureBuilder(
          future: _getImageAsset(dialogImage),
          builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Placeholder while loading
            } else if (snapshot.hasError) {
              return Text('Error loading image');
            } else {
              return AlertDialog(
                title: Text(dialogText),
                content: Container(
                    constraints: BoxConstraints(
                        maxWidth: 200,
                        maxHeight: 200), // Adjust size constraints as needed
                    child: Image.asset(
                      dialogImage,
                      fit: BoxFit
                          .contain, // Ensure the image fits within the container
                    )), // Show the image
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
            }
          },
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

  void restartGame({Difficulty difficulty = Difficulty.Normal}) {
    setState(() {
      gameEnded = false; // Reset game state

      switch (difficulty) {
        case Difficulty.Harder:
          globalTemperature = 16.0; // Reset global temperature
          globalSustainabilityIndex = 75.0; // Reset global sustainability index
          playerProbabilityPowerLevel = 0.5; // Reset probability power level
          sustainabilityOveruseFactor = 0.25;
          print("Restarting game with hard difficulty");
          break;

        case Difficulty.Hardest:
          globalTemperature = 17.0; // Reset global temperature
          globalSustainabilityIndex = 50.0; // Reset global sustainability index
          playerProbabilityPowerLevel = 0.25; // Reset probability power level
          sustainabilityOveruseFactor = 0.5;
          print("Restarting game with hardest difficulty");
          break;

        default:
          globalTemperature = 15.0; // Reset global temperature
          globalSustainabilityIndex =
              100.0; // Reset global sustainability index
          playerProbabilityPowerLevel = 1.0; // Reset probability power level
          sustainabilityOveruseFactor = 0.1;
          print("Restarting game with normal difficulty");
          break;
      }
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

  void handleRestartGame(Difficulty? selectedValue) {
    if (selectedValue != null) {
      restartGame(difficulty: selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Green Destiny')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Scenario: $currentScenario',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
                height:
                    kToolbarHeight), // Add space equal to the height of the AppBar
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Tooltip(
                  message:
                      'Boost or weaken outcomes to reduce or increase global temperature', // Tooltip message
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
                      child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensures the Row takes as little space as possible
                          children: [
                            Icon(Icons.add_circle_outline), // Icon
                            SizedBox(width: 8), // Spacer between icon and text
                            Text('Boost',
                                style: new TextStyle(fontSize: 10)) // Text
                          ]),
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
                      child: Row(
                          mainAxisSize: MainAxisSize
                              .min, // Ensures the Row takes as little space as possible
                          children: [
                            Icon(Icons.remove_circle_outline), // Icon
                            SizedBox(width: 8), // Spacer between icon and text
                            Text('Weaken',
                                style: new TextStyle(fontSize: 10)) // Text
                          ]),
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
                          child: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Ensures the Row takes as little space as possible
                              children: [
                                Icon(Icons.not_interested), // Icon
                                SizedBox(
                                    width: 8), // Spacer between icon and text
                                Text('Nothing',
                                    style: new TextStyle(fontSize: 10)) // Text
                              ]))),
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
                        minRadius: minRadius,
                        maxRadius: maxRadius,
                        clockwiseRotation: clockwiseRotation),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Restart'),
                  SizedBox(width: 8), // Adjust spacing as needed
                  DropdownButton<Difficulty>(
                    value: Difficulty.Normal,
                    onChanged: handleRestartGame,
                    items: Difficulty.values.map((Difficulty value) {
                      return DropdownMenuItem<Difficulty>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
