import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signUp(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful')),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 40.0),
            _buildHeader(),
            SizedBox(height: 24.0),
            _buildTextField(label: 'Full Name', icon: Icons.person, controller: fullNameController),
            SizedBox(height: 16.0),
            _buildTextField(label: 'Email', icon: Icons.email, controller: emailController),
            SizedBox(height: 16.0),
            _buildTextField(label: 'Password', icon: Icons.lock, isPassword: true, controller: passwordController),
            SizedBox(height: 24.0),
            _buildSignUpButton(context),
            _buildGoogleSignUpButton(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              // Already on sign-up screen
              break;
            case 2:
              Navigator.pushNamed(context, '/calculator');
              break;
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.person_add, size: 80.0, color: Colors.teal),
          SizedBox(height: 16.0),
          Text(
            'Create Your Account',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, bool isPassword = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signUp(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildGoogleSignUpButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _signInWithGoogle(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Text(
        'Sign Up with Google',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign In with Google Successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }
}
