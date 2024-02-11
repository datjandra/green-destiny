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
                      constraints: BoxConstraints(
                          maxWidth: 200,
                          maxHeight: 200), // Adjust size constraints as needed
                      child: Image.asset(
                        'assets/images/portrait.png',
                        fit: BoxFit
                            .contain, // Ensure the image fits within the container
                      )),
                  SizedBox(height: 20),
                  Text(
                    'Welcome, Green Destiny!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Your mission is to lower global temperatures with your awesome probability-altering powers. '
                    'Encounter various scenarios affecting global temperatures and sustainability. '
                    'Boost positive events that reduce global temperatures and weaken negative '
                    'ones that raise them. You can choose to do nothing, but beware of chaos from high temperatures. '
                    'Your power may strengthen with each use, but more influential scenarios require more power to '
                    'alter. Be careful, as your power affects the fabric of reality and excessive use drains resources and leads to chaos.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      navigateToGamePage(
                          context); // Invoke the callback function
                    },
                    child: Row(
                        mainAxisSize: MainAxisSize
                            .min, // Ensures the Row takes as little space as possible
                        children: [
                          Icon(Icons.play_arrow), // Icon
                          SizedBox(width: 8), // Spacer between icon and text
                          Text('Start') // Text
                        ]),
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
