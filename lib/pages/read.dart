import 'package:coinboost/pages/news.dart';
import 'package:flutter/material.dart';

class ReadNewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read And Earn"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container (Above Rules)
            Container(
              margin: EdgeInsets.only(bottom: 20), // Space below the image
              height: 200, // Adjust height as needed
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/images/n.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            // Rules Section
            Text("Rules of the Task:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("1. Keep scrolling for 10 minutes."),
            Text("2. Keep touching the screen every 30 sec."),
            Text("3. Don't keep the screen still for more than 30 sec."),
            SizedBox(height: 20),

            // Start Button (Navigates to News Task Page with Data)
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsTaskScreen(),
                    ),
                  );
                },
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
