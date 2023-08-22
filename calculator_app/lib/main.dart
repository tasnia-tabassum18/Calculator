import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; //used this package for maths expressions

void main() {
  runApp(Calculator());
}
class Calculator extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}
class SimpleCalculator extends StatefulWidget {


  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  static const Color containerColor = Color(0xFF063970);
  static const Color btnColor = Color(0xFF154C79);
  //for button pressed method
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  // defining function
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "="){
       equationFontSize = 38.0;
       resultFontSize = 48.0;
       expression = equation;
       expression = expression.replaceAll('x', '*');
       expression = expression.replaceAll('/', '÷');

       try {
         Parser p =  new Parser();
         Expression exp = p.parse(expression);

         ContextModel cm = ContextModel();
         result = '${exp.evaluate(EvaluationType.REAL, cm)}';

       }
       catch(e){
         result = "Error";
       }

      }
      else {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        if(equation == "0"){
          equation = buttonText;
        } else {
        equation = equation + buttonText;
      }
      }
    });
  }



  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: TextButton(
          onPressed: () => (buttonPressed(buttonText)),

          style: TextButton.styleFrom(
            // Text style
            padding: EdgeInsets.all(16.0), // Button padding
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                // side: BorderSide(
                //   color: Colors.white,
                //   width: 1,
                //   style: BorderStyle.solid,
                // )// Button border radius
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: containerColor, centerTitle: true, title: Text('Calculator')),
      body: Column(

        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            Container(
              color: containerColor,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
              child: Text(equation, style: TextStyle(fontSize: equationFontSize,color: Colors.white)),
            ),
          Container(
            color: containerColor,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize, color: Colors.white)),
          ),
          // dividing the screen in half
          //first part
          Expanded(
            child: Container(
              color: containerColor, // Set the background color for the Divider
              child: Divider(

              ),
            ),
          ),
          //bottom

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(

                width: MediaQuery.of(context).size.width * .75 ,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("v", 1, btnColor), //calling the method defined earlier
                        buildButton("C", 1, btnColor),
                        buildButton("x", 1, btnColor),
                        // buildButton("/", 1, btnColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("(", 1, btnColor), //calling the method defined earlier
                        buildButton(")", 1, btnColor),
                        buildButton("%", 1, btnColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, btnColor), //calling the method defined earlier
                        buildButton("2", 1, btnColor),
                        buildButton("3", 1, btnColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, btnColor), //calling the method defined earlier
                        buildButton("5", 1, btnColor),
                        buildButton("6", 1, btnColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, btnColor), //calling the method defined earlier
                        buildButton("8", 1, btnColor),
                        buildButton("9", 1, btnColor),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("0", 1, btnColor), //calling the method defined earlier
                        buildButton("00", 1, btnColor),
                        buildButton(".", 1, btnColor),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25, //rest 25% of the screen
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("/", 1, btnColor)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("*", 1, btnColor)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, btnColor)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, btnColor)
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, btnColor)
                        ]
                    ),
                  ],
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}



