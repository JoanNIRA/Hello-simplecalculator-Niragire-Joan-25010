import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:async';

void main() {
  runApp(ModernCalculatorApp());
}

class ModernCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.black,
          secondary: Colors.blue,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CalculatorHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Hello',
          style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _displayText = "0";
  String _currentExpression = "";

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _displayText = "0";
        _currentExpression = "";
      } else if (buttonText == "CE") {
        if (_currentExpression.isNotEmpty) {
          _currentExpression = "";
          _displayText = "0";
        }
      } else if (buttonText == "=") {
        try {
          Expression expression = Expression.parse(_currentExpression);
          final evaluator = const ExpressionEvaluator();
          var result = evaluator.eval(expression, {});
          _displayText = result.toString();
          _currentExpression = _displayText;
        } catch (e) {
          _displayText = "Error";
        }
      } else if (buttonText == "<") {
        if (_currentExpression.isNotEmpty) {
          _currentExpression = _currentExpression.substring(0, _currentExpression.length - 1);
          _displayText = _currentExpression.isEmpty ? "0" : _currentExpression;
        }
      } else if (buttonText == "+/-") {
        if (_currentExpression.isNotEmpty && _currentExpression != "0") {
          if (_currentExpression.startsWith('-')) {
            _currentExpression = _currentExpression.substring(1);
          } else {
            _currentExpression = '-' + _currentExpression;
          }
          _displayText = _currentExpression;
        }
      } else if (buttonText == "%") {
        if (_currentExpression.isNotEmpty) {
          try {
            Expression expression = Expression.parse(_currentExpression);
            final evaluator = const ExpressionEvaluator();
            var result = evaluator.eval(expression, {});
            _currentExpression = (result / 100).toString();
            _displayText = _currentExpression;
          } catch (e) {
            _displayText = "Error";
          }
        }
      } else {
        if (_displayText == "0" && buttonText != ".") {
          _currentExpression = buttonText;
        } else {
          _currentExpression += buttonText;
        }
        _displayText = _currentExpression;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color, IconData? icon}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: color ?? Colors.grey[800],
            foregroundColor: Colors.white,
          ),
          onPressed: () => _onButtonPressed(buttonText),
          child: icon != null
              ? Icon(icon, size: 24.0)
              : Text(
                  buttonText,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Calculator', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              _displayText,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("%"),
                  _buildButton("CE"),
                  _buildButton("C", color: Colors.red),
                  _buildButton("<", icon: Icons.backspace),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/", color: Colors.blue),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*", color: Colors.blue),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-", color: Colors.blue),
                ],
              ),
              Row(
                children: [
                  _buildButton("+/-"),
                  _buildButton("0"),
                  _buildButton("."),
                  _buildButton("+", color: Colors.blue),
                ],
              ),
              Row(
                children: [
                  _buildButton("=", color: Colors.blue),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
