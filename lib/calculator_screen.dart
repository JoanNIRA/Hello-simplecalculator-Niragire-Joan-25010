import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.teal,
      ),
      body: Calculator(),
      backgroundColor: Color.fromARGB(255, 164, 162, 162), // Set background color to grey
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "DEL") {
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "X") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, {Color textColor = Colors.white, Color bgColor = Colors.teal}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(18.0),
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: textColor),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Set background color to grey
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          Divider(color: Colors.black),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildButtonRow(["C", "DEL", "/", "X"], bgColor: const Color.fromARGB(255, 0, 191, 255)),
              buildButtonRow(["7", "8", "9", "-"], bgColor: const Color.fromARGB(255, 0, 191, 255)),
              buildButtonRow(["4", "5", "6", "+"], bgColor: const Color.fromARGB(255, 0, 191, 255)),
              buildButtonRow(["1", "2", "3", "="], bgColor: const Color.fromARGB(255, 0, 191, 255)),
              buildButtonRow(["0", ".", "00"], bgColor: const Color.fromARGB(255, 0, 191, 255)),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttonTexts, {Color textColor = Colors.white, Color bgColor = Colors.teal}) {
    return Row(
      children: buttonTexts.map((text) {
        return buildButton(text, textColor: textColor, bgColor: bgColor);
      }).toList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculatorScreen(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

