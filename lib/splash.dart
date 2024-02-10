import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  final Function navigateToGamePage;

  SplashScreen(this.navigateToGamePage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getImageAsset(
            'assets/images/portrait.png'), // Your method to load the image asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator while waiting for the image to load
          } else if (snapshot.hasError) {
            return Text(
                'Error loading image'); // Show an error message if image loading fails
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                      child: Image.asset(
                        'assets/images/portrait.png',
                        fit: BoxFit
                            .contain, // Ensure the image fits within the container
                      )),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to Green Destiny!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your mission is to lower global temperatures using probability-altering powers. '
                    'Encounter various scenarios affecting global temperatures and sustainability. '
                    'Boost positive events that reduce global temperatures and weaken negative '
                    'ones that raise them. You can choose to do nothing, but beware of chaos from high temperatures. '
                    'Your power strengthens with each use, but more influential scenarios require more power to '
                    'change. Be careful, as your power affects reality itself and excessive use drains resources and leads to chaos.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      navigateToGamePage(
                          context); // Invoke the callback function
                    },
                    child: Text('Start'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Image> _getImageAsset(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    return Image.memory(bytes);
  }
}
