import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Function navigateToGamePage;

  SplashScreen(this.navigateToGamePage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Green Destiny!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add your instructions here
            _buildInstructionBullet(
                'Step into the shoes of Green Destiny, a hero with the awesome power to alter probabilities.'),
            _buildInstructionBullet(
                'Face different challenges affecting the world\'s temperature and sustainability.'),
            _buildInstructionBullet(
                'Use your power to boost or weaken the impact of each challenge, or choose to do nothing.'),
            _buildInstructionBullet(
                'Your power grows stronger each time you use it.'),
            _buildInstructionBullet(
                'Keep in mind that tougher challenges require a higher power level to influence.'),
            _buildInstructionBullet(
                'Be careful! Using your power too much drains the planet\'s resources and causes chaos.'),
            _buildInstructionBullet(
                'Your mission is to lower the global temperature using your unique abilities.'),
            _buildInstructionBullet(
                'But watch out! Letting the temperature rise too much will bring chaos.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                navigateToGamePage(context); // Invoke the callback function
              },
              child: Text('Start'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
