import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.teal, // Set app bar background color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 24.0),
            _buildHeader(), // Custom header widget
            SizedBox(height: 24.0),
            _buildTextField(label: 'Full Name', icon: Icons.person),
            SizedBox(height: 16.0),
            _buildTextField(label: 'Email', icon: Icons.email),
            SizedBox(height: 16.0),
            _buildTextField(label: 'Password', icon: Icons.lock, isPassword: true),
            SizedBox(height: 24.0),
            _buildSignUpButton(), // Custom sign-up button widget
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        Icon(
          Icons.account_circle,
          size: 100.0,
          color: Colors.teal,
        ),
        SizedBox(height: 8.0),
        Text(
          'Create an Account',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTextField({required String label, required IconData icon, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement sign-up logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Set button background color
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpScreen(),
    theme: ThemeData.light(), // Use light theme for better visibility
    debugShowCheckedModeBanner: false,
  ));
}
