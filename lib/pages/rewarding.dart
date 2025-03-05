import 'package:coinboost/pages/home.dart';
import 'package:flutter/material.dart';

class RewardingLevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rewarding Levels"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            RewardLevelCard(level: 1, minWithdrawal: 50, earnings: 25),
            RewardLevelCard(level: 2, minWithdrawal: 100, earnings: 15),
            RewardLevelCard(level: 3, minWithdrawal: 150, earnings: 33),
          ],
        ),
      ),
    );
  }
}

class RewardLevelCard extends StatelessWidget {
  final int level;
  final double minWithdrawal;
  final double earnings;

  const RewardLevelCard({
    required this.level,
    required this.minWithdrawal,
    required this.earnings,
  });

  @override
  Widget build(BuildContext context) {
    double progress = earnings / minWithdrawal;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Orange Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(
              "Level ${level.toString().padLeft(2, '0')}", // Format "01, 02"
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Minimum Withdrawal = \$${minWithdrawal.toInt()}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Your earnings = \$${earnings.toInt()}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),

                // Progress Bar with Percentage
                Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: progress > 1.0 ? 1.0 : progress,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
