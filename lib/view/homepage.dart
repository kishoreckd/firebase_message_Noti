import 'package:flutter/material.dart';

import '../controller/auth_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
