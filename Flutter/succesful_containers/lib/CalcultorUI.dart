import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String equation = "0", result = "0"; // Expression and FinalResult
  Map<String, String> operatorsMap = {"÷": "/", "×": "*", "−": "-", "+": "+"};
  List buttonNames = [
    "7",
    "8",
    "9",
    "÷",
    "4",
    "5",
    "6",
    "×",
    "1",
    "2",
    "3",
    "−",
    "0",
    ".",
    "⌫",
    "+"
  ];

  void evaluateEquation() {
    try {
      // Fix equation
      Expression exp = (Parser()).parse(operatorsMap.entries.fold(
          equation, (prev, elem) => prev.replaceAll(elem.key, elem.value)));

      double res = double.parse(
          exp.evaluate(EvaluationType.REAL, ContextModel()).toString());

      // Output correction for decimal results
      result = double.parse(res.toString()) == int.parse(res.toStringAsFixed(0))
          ? res.toStringAsFixed(0)
          : res.toStringAsFixed(4);
    } catch (e) {
      result = "Error";
    }
  }

  Widget _buttonPressed(String text, {bool isClear = false}) {
    setState(() {
      if (isClear) {
        // Reset calculator
        equation = result = "0";
      } else if (text == "⌫") {
        // Backspace
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") equation = result = "0"; // If all empty
      } else {
        // Default
        if (equation == "0" && text != ".") equation = "";
        equation += text;
      }

      // Only evaluate if correct expression
      if (!operatorsMap.containsKey(equation.substring(equation.length - 1)))
        evaluateEquation();
    });
  }

  // Grid of buttons
  Widget _buildButtons() {
    return Material(
      color: Color(0xFFF2F2F2),
      child: GridView.count(
          crossAxisCount: 4, // 4x4 grid
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: buttonNames.map<Widget>((e) {
            switch (e) {
              case "+": // Addition Button
                return _buildFancyButton(e, isBottom: true);
              case "×": // Multiplication Button
                return _buildFancyButton(e);
              case "−": // Subtraction Button
                return _buildFancyButton(e);
              case "÷": // Division Button
                return _buildFancyButton(e, isTop: true);
              default:
                return _button(e, 0);
            }
          }).toList()),
    );
  }

  // Normal button
  Widget _button(text, double paddingBot) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(100)), // Circular
        color: Color.fromRGBO(230, 230, 230, 1),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return InkWell(
              // Ripple Effect
              borderRadius: BorderRadius.all(Radius.circular(100)),
              onTap: () {
                _buttonPressed(text);
              },
              child: Container(
                // For ripple area
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color.fromRGBO(94, 94, 94, 1),
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  // Operator Button
  Widget _buildFancyButton(text, {bool isTop = false, bool isBottom = false}) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, isTop ? 8 : 0, 8, isBottom ? 8 : 0),
      child: Material(
        color: Color.fromRGBO(237, 65, 53, 1),
        borderRadius: BorderRadius.vertical(
            top: isTop ? Radius.circular(100.0) : Radius.circular(0),
            bottom: isBottom ? Radius.circular(100.0) : Radius.circular(0)),
        child: InkWell(
          borderRadius: BorderRadius.vertical(
              top: isTop ? Radius.circular(100.0) : Radius.circular(0),
              bottom: isBottom ? Radius.circular(100.0) : Radius.circular(0)),
          onTap: () {
            _buttonPressed(text);
          },
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color.fromRGBO(255, 211, 215, 1),
                fontSize: 30.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ),
    );
  }
  dialogPlease(){
    showDialog(context: context,
    builder:(context){
      return Padding(
            padding: const EdgeInsets.only(top:220.0),
            child: _buildButtons()
          );
    }

    );
  }
  // Whether the green box should be visible
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Expanded(
            // Expression Area - Top - Smallest Size
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 12.5, right: 12.5),
              decoration: BoxDecoration(
                // Bottom Divider
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(227, 227, 227, 1),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // Expression
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    child: Row(
                      children: <Widget>[
                        Text(equation,
                            style: TextStyle(
                                fontSize: 30,
                                color: Color.fromRGBO(152, 152, 152, 1),
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    child: FloatingActionButton(
                      onPressed: () {
                        dialogPlease();
                        // Call setState. This tells Flutter to rebuild the
                        // UI with the changes.
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                      tooltip: 'Toggle Opacity',
                      child: Icon(Icons.flip),
                    ),
                  ),
                  Container(
                    // Clear Btn
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          onTap: () => {_buttonPressed("×", isClear: true)},
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            child: Text(
                              "×",
                              style: TextStyle(
                                  fontSize: 36,
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            // Result Area - Mid - Medium Size Ratio
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.fromLTRB(14, 8, 14, 0),
                child: Text(
                  result,
                  style: TextStyle(
                      color: Color.fromRGBO(227, 227, 227, 1),
                      fontSize: 70,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Chivo'),
                ),
              ),
            ),
          ),
          Expanded(
            // Controls Area - Bottom - Max Size Ration
            flex: 5,
            child: IconButton(icon: Icon(Icons.local_activity), 
            onPressed: null)
          )
        ],
      ),
    );
  }
}
