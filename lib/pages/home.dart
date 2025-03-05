import 'dart:io';

import 'package:coinboost/pages/read.dart';
import 'package:flutter/material.dart';
import 'package:coinboost/pages/rewarding.dart';
import 'package:coinboost/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import ReadNewsScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreenContent(),
    RewardingLevelsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: "Rewards"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  File? _profileImage;
  final String _imageKey = "profile_image"; // Key for SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  // Load the saved profile picture
  Future<void> _loadProfileImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(_imageKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CoinBoost"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage("assets/user.png") as ImageProvider,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.emoji_events,
                            size: 18, color: Colors.orange),
                        SizedBox(width: 5),
                        Text("Level 01"),
                        SizedBox(width: 10),
                        Icon(Icons.account_balance_wallet,
                            size: 18, color: Colors.green),
                        SizedBox(width: 5),
                        Text("\$25.00"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Daily Reward Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Claim your Daily Reward",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60, // Set a fixed height for the scrollable row
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6, // Number of days
                    itemBuilder: (context, index) {
                      bool isToday = index == 2; // Highlight today's reward
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8), // Spacing
                        child: Container(
                          width: 60, // Set a fixed width for each reward
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isToday ? Colors.white : Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                            border: isToday
                                ? Border.all(color: Colors.orange, width: 2)
                                : null,
                          ),
                          child: Text(
                            "\$2 AD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isToday ? Colors.orange : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Image Containers with Text Overlay
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage("assets/images/g.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  bottom: 15,
                  right: 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Play Games",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      Text(
                        "\$10",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            // Read News Container with Tap Action
            GestureDetector(
              onTap: () {
                // Navigate to ReadNewsScreen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReadNewsScreen()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage("assets/images/n.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    bottom: 15,
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Read News",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Text(
                          "\$10",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
