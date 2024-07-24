import 'package:flutter/material.dart';

import '../controller/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  await AuthService.loginWithEmail(
                    _emailController.text,
                    _passwordController.text,
                  ).then((value) {
                    if (value == 'Login Successfull') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login Successfull'),
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/home", // Ensure this matches the route name in your MaterialApp
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade50,
                        ),
                      );
                    }
                  });
                },
                child: const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No Account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/signup");
                      },
                      child: Text("SignUp"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
