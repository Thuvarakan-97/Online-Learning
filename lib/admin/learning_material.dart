import 'package:flutter/material.dart';
import 'package:online_learning/admin/ass/add_del.dart';
import 'package:online_learning/admin/add_video.dart';
import 'package:online_learning/admin/game/add_game.dart';

class LearningMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Material'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Training Video page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoUploader()),
                );
              },
              child: Text('Training Video'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 1, 235, 235),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Game Hub page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => game1()),
                );
              },
              child: Text('Game Hub'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Assessment page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => add_del()),
                );
              },
              child: Text('Assessment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 2, 250, 212),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Hub'),
      ),
      body: Center(
        child: Text('This is the Game Hub page'),
      ),
    );
  }
}
