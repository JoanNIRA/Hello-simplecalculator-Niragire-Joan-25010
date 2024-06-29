import 'package:flutter/material.dart';
import 'SignUpScreen.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Colors.teal, // Set app bar background color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 40.0),
            _buildHeader(), // Custom header widget
            SizedBox(height: 24.0),
            _buildTextField(label: 'Email', icon: Icons.email),
            SizedBox(height: 16.0),
            _buildTextField(label: 'Password', icon: Icons.lock, isPassword: true),
            SizedBox(height: 24.0),
            _buildSignInButton(), // Custom sign-in button widget
            SizedBox(height: 16.0),
            _buildSignUpLink(context), // Sign up link widget
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        Icon(
          Icons.lock_outline,
          size: 100.0,
          color: Colors.teal,
        ),
        SizedBox(height: 8.0),
        Text(
          'Sign In to Your Account',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
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

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement sign-in logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Set button background color
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        'Sign In',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildSignUpLink(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to sign up screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      },
      child: Text(
        'Don\'t have an account? Sign Up',
        style: TextStyle(
          color: Colors.teal,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
