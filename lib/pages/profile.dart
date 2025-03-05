import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coinboost/pages/home.dart';
import 'package:coinboost/pages/start.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final String _imageKey = "profile_image"; // Key for SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  // Load saved image path from SharedPreferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString(_imageKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  // Pick image from gallery and save it
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _saveImage(pickedFile.path); // Save image path
    }
  }

  // Save image path to SharedPreferences
  Future<void> _saveImage(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_imageKey, path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : AssetImage('assets/images/avatar.png') as ImageProvider,
                child: _image == null
                    ? Icon(Icons.camera_alt, color: Colors.white, size: 30)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            Text("User",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("User123@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartPage()),
                );
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
