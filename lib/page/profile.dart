import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  String name = '';
  String email = '';

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Welcome to Profile Page'),
            SizedBox(height: 16),
            CircleAvatar(
              radius: 50,
              child: const Icon(Icons.person),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name: '),
                Text(name),
                SizedBox(height: 16),
                const Text('Email: '),
                Text(email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
