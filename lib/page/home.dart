import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          const Text('Welcome to Home Page'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 50,
                  child: const Icon(Icons.person),
                ),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Name: '),
                  Text(name),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: const Text('Go to Profile Page'),
          ),
        ],
      ),
    );
  }
}
