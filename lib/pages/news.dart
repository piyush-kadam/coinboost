import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class NewsTaskScreen extends StatefulWidget {
  @override
  _NewsTaskScreenState createState() => _NewsTaskScreenState();
}

class _NewsTaskScreenState extends State<NewsTaskScreen> {
  List<dynamic> _newsArticles = [];
  bool _isLoading = true;
  Timer? _timer;
  int _remainingTime = 600; // 10 minutes in seconds

  @override
  void initState() {
    super.initState();
    fetchNews();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    setState(() {
      _remainingTime = 600;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  Future<void> fetchNews() async {
    final url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=YOUR API KEY');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _newsArticles = data['articles'];
          _isLoading = false;
        });
      } else {
        throw Exception("Failed to load news");
      }
    } catch (error) {
      print("Error fetching news: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read And Earn"),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _newsArticles.isEmpty
                  ? Center(child: Text("No news available"))
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 100, left: 10, right: 10),
                      itemCount: _newsArticles.length,
                      itemBuilder: (context, index) {
                        var article = _newsArticles[index];
                        return NewsCard(
                          title: article['title'] ?? "No title",
                          description:
                              article['description'] ?? "No description",
                          imageUrl: article['urlToImage'] ?? "",
                        );
                      },
                    ),

          // Timer Pop-up at the Top
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Time Remaining: ${formatTime(_remainingTime)}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      // Handle claim reward logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Reward Claimed Successfully!")),
                      );
                    },
                    child: Text("Claim", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const NewsCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(imageUrl,
                  width: double.infinity, height: 200, fit: BoxFit.cover),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
