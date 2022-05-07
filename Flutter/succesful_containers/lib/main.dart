import 'dart:collection';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:external_app_launcher/external_app_launcher.dart';

// import 'package:speech_recognition/speech_recognition.dart';

// import 'CalcultorUI.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SpeechRecoTest());
  Queue numQ = new Queue();
  numQ.add(5);
  // Our first LinkedList
  var propertyVal = new LinkingList();
  propertyVal.insertData(testValue());
}

class TipCalculatorApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip App',
      theme: ThemeData(primaryColor: Colors.green),
      home: TipCalculatorPage(),
    );
  }
}

class NodeClass {
  testValue data;
  NodeClass next;
}

class LinkingList {
/*
this class will insert data into the lists
and show the data as well
*/
/*
if our list is empty, the starting point of node, we will call it head, is null
however, if the list has at least one value the head is not null
*/
  NodeClass head;

  void insertData(testValue data) {
    var node = NodeClass();
    node.data = data;
// at the beginning
    node.next = head;
    if (head == null) {
      head = node;
    } else {
      NodeClass currentPosition = head;
      while (currentPosition.next != null) {
        currentPosition.next = node;
      }
// we take the last value added and print it out
      print("One value is added to the list. ${node.data}");
    }
  }

  void showData() {
    NodeClass node = head;
// this method will work when the first value is added
    if (head == null) {
      print("No value has been added in the list. It is empty.");
    } else {
      print("One value is added to the list: ${node.data}");
    }
  }
}

class TipCalculatorPage extends StatefulWidget {
  // This widget is the home screen of the Tip Calculator app. It is stateful, since we want
  // to keep track of the TipAmount & TotalAmount and update the UI accordingly
  @override
  _TipCalculatorPageState createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage>
    with TickerProviderStateMixin {
  // This is the default bill amount
  static const defaultBillAmount = 0.0;

  // This is the default tip percentage
  static const defaultTipPercentage = 15;

  // This is the TextEditingController which is used to keep track of the change in bill amount
  final _billAmountController =
      TextEditingController(text: defaultBillAmount.toString());

  // This is the TextEditingController which is used to keep track of the change in tip percentage
  final _tipPercentageController =
      TextEditingController(text: defaultTipPercentage.toString());

  // This stores the latest value of bill amount calculated
  double _billAmount = defaultBillAmount;

  // This stores the latest value of tip percentage calculated
  int _tipPercentage = defaultTipPercentage;

  //our list
  List<testValue> dearData = [];

  List<String> equations = new List(10);

  // Calculator Part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//??????????????????????????????????????????????????????????????????????????
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
      if (text == "×") {
        okDokecky();
        // equations.add("2");
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

  dialogPlease() {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 220.0),
              child: _buildButtons());
        });
  }

  // Whether the green box should be visible
  bool _visible = true;

// Calculator Part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//??????????????????????????????????????????????????????????????????????????
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  _onBillAmountChanged() {
    setState(() {
      _billAmount = double.tryParse(_billAmountController.text) ?? 0.0;
    });
  }

  _onTipAmountChanged() {
    setState(() {
      _tipPercentage = int.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  //This method is used to calculate the latest tip amount
  _getTipAmount() => _billAmount * _tipPercentage / 100;

  //This method is used to calculate the latest total amount
  _getTotalAmount() => _billAmount + _getTipAmount();
  goPapi() => 5 + 2;

  var _results = {
    'Key_1': 'Value_1',
    'Key_2': 'Value_2',
  };

  List<TextEditingController> totoControll = List(10);
  List<Function> totiFunction;
  List<int> toteCalculateFun = List(10);
  List<String> totaVariable = List(10);
  List<int> addedOp = List(10);

  bool calcSum;
  bool calcDiff;
  bool calcMult;
  bool calcDIVision;
  bool yours = false;
  int addTesting;
  int addTesting_2;
  int addTot;
  final iterNum = 6;
  String backUp = "0";
  String frontUp = "0";
  List<String> backList = new List(10);
  List<String> frontList = new List(10);

  // toto.forEach((element) {new List(10)});

  // This fction creates textEditingControllers, initializes and
  // pass them to specific variables.
  // !!!!!   Caution !!!!!! Not stable. Needs to be changed.
  letSgo(int vault) {
    for (int a = 0; a < vault; a++) {
      toteCalculateFun = new List(vault);

      totoControll[a] = new TextEditingController();

      totoControll[a].addListener(() {
        setState(() {
          // calculateTest(a);
          totaVariable[a] = totoControll[a].text ?? 0;
        });
      });
    }
  }

  // calculateTest(int calc) {
  //   addedOp[calc] = totaVariable[calc];
  //   addTesting = totaVariable[1];
  //   addTesting_2 = totaVariable[2];
  //   if (calcSum == true) {
  //     addTot = addTesting + addTesting_2;
  //   } else {
  //     addTot = 0;
  //   }
  //   if (calcDiff == true) {
  //     // addTesting = totaVariable[1];
  //     // addTesting_2 = totaVariable[2];
  //     addTot = addTesting - addTesting_2;
  //   } else {
  //     addTot = 0;
  //   }
  //   return addedOp;
  // }

  //function mine
  // getPapu() {
  //   testValue(_tipPercentageController);
  // }
  // testValue(_tipPercentageController);
  int n = 3;
  String tempVar;
  frontOperation(int n) {
    for (int i = 0; i < frontList.length; i++) {
      frontList[i] = "0";
    }
    frontList[n] = equation;
    if (equation.contains("×")) {
      frontList[n] = equation.substring(0, equation.indexOf("×"));
    }
    // if (k >= 3) {
    //   tempVar = frontUp;
    //   frontUp = backUp;
    //   backUp = tempVar;
    // }
    return frontList[n];
  }

  lestDoThis() {
    for (int i = 0; i < backList.length; i++) {
      backList[i] = "0";
    }
  }

  backOperation(int n) {
    if (equation.length == 0) {
      // backUp = equation;
      equation = "0";
      backList[n] = equation;
    } else if (equation.contains("×")) {
      // backUp = equation.substring(equation.indexOf("×") + 1);
      backList[n] = equation.substring(equation.indexOf("×") + 1);
    }
    // backUp = equation.substring(1);

    return backList[n];
  }

// helloMetho(int n)=> helloCalc[n];
  showmePlease() {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 200.0), child: helloCalc[0]);
        });
  }

  //yOU CAN DELETE THIS
  AnimationController _controller;
  Animation<Offset> _animation;

  //yOU CAN DELETE THIS

  @override
  void initState() {
    super.initState();
    _billAmountController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));

    // resultingList[0] = resulting;
    // firstOperandsList[0] = firstOperand;
    // secondOperandsList[0] = secondOperand;
    // Here it is
    letSgo(5);
  }

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  List<_testValueState> toast = [_testValueState()];
  List<int> newList = [0];
  tryThat() {
    // helloCalc.add(Calculation());
    // toast.add(52);
    // toast.add(85);
    print(listsumOperation);
  }

  loopThrough() {
    newList[0] = toast[0].returnsumOperation();
  }

  // clearSum() {
  //   listsumOperation.clear();
  // }

  String boulanger = "0";
  bool positionSilde = false;
  String summation;
  // int summing = 0;

  List<Calculation> helloCalc = [];
  // methodHeCa(){
  //   for (int i=0;i<5;i++){
  //     helloCalc[]
  //   }

  // }
  // TESTING
  bool _first = true;

  double _left = 20;
  double _top = 20;
  double _right = 20;
  double _bottom = 20;
  //TESTING
  bool scrollVerify = false;
  ScrollController _scrollController = ScrollController();
  scroller() {
    if (scrollVerify == true) {
      _scrollController.animateTo(25,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  // columnLoop() {
  //   return SingleChildScrollView(
  //     controller: _scrollController,
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       // mainAxisSize: MainAxisSize.min ,
  //       // mainAxisAlignment: MainAxisAlignment.center,
  //       // crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Property(totoControll[1], addedOp),
  //         SizedBox(
  //           width: 10,
  //         ),
  //         for (int j = 0; j < k; j++)
  //           testValue(firstOperand.toString(), secondOperand.toString()),

  //         // loopThrough(),
  //         IconButton(
  //             icon: Icon(Icons.add_circle),
  //             iconSize: 30,
  //             // color: Colors.purple,
  //             onPressed: () {
  //               setState(() {
  //                 // loopThrough();
  //                 toast.add(_testValueState());
  //                 okDokecky();
  //                 // okList();

  //                 // barber = true;
  //               });
  //             }),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         IconButton(
  //             icon: Icon(Icons.account_box_outlined),
  //             onPressed: () {
  //               setState(() {
  //                 k -= 1;
  //                 if (k <= 0) {
  //                   clearSum();
  //                 }
  //               });
  //             }),
  //       ],
  //     ),
  //   );
  // }
  reveal() {
    if (kTruth = true) {
      a = z;
    } else {
      return a;
    }
  }

  toTablePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BiggerTableData(Column(
                  children: [
                    // SizedBox(
                    //   height: 20,
                    // ),
                    for (int j = 0; j < bestListFirstOp.length; j++)
                      TableData(
                          MiniProperty(totoControll[j].text),
                          Row(
                            children: [
                              for (int o = 0;
                                  o < bestListFirstOp[j].length;
                                  o++)
                                MiniTestValue(j, o)
                            ],
                          ))
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    // boulanger = _getDisplayText();
    // summation = sum.toString();
    // lestDoThis();
    // loopThrough();
    // sumo = lol;
    // scroller();

    // This method builds the UI of the Tip Calculator.
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tip Calculator',
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.red,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 7, 10, 0),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.0),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                height: 344,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              // letSgo(5, true),
                              IconButton(
                                  icon: Icon(
                                    Icons.check_circle,
                                    size: 40,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      toTablePage();
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.exposure_minus_1_rounded,
                                    size: 40,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      calcDiff = true;
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () {
                                    calcSum = true;
                                    setState(() {
                                      calcSum = true;
                                      // okList();
                                      print(listTestVal);
                                      print(kLists);
                                      // it's here
                                      // listTestVal.add(testValue());
                                      // okDokecky();
                                      // addTot = addTesting + addTesting_2;
                                      print("to Chris");
                                      positionSilde = true;
                                      tryThat();
                                      if (barber = true) {
                                        print(lol);
                                      }
                                      // scrollVerify = true;
                                      // scroller();
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.label_important,
                                    color: Colors.deepPurpleAccent,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      // dialogPlease();
                                      // replicateCalculation();
                                      showmePlease();
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    size: 40,
                                    color: Colors.yellow,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      n -= 1;
                                      if (col < 1) {
                                        col = 1;
                                      } else {
                                        col -= 1;
                                      }

                                      bestListFirstOp
                                          .removeAt(bestListFirstOp.length - 1);
                                      bestListSectOp
                                          .removeAt(bestListSectOp.length - 1);
                                      listTestVal
                                          .removeAt(listTestVal.length - 1);
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      n += 1;

                                      colDockey();
                                      bestListFirstOp.add([]);
                                      bestListSectOp.add([]);
                                      kLists.add([1]);
                                      listTestVal.add([testValue()]);

                                      tabDockey();
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        )),
                    Column(
                      children: [
                        for (int j = 0; j < col; j++)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ColumnLooping(
                                    _scrollController,
                                    Property(totoControll[j], addedOp),
                                    Row(
                                      children: [
                                        for (int i = 0; i < kLists[j][0]; i++)
                                          listTestVal[j][i]
                                        // listTestVal[i]
                                      ],
                                    )),
                                IconButton(
                                    icon: Icon(Icons.add_circle),
                                    iconSize: 30,
                                    // color: Colors.purple,
                                    onPressed: () {
                                      setState(() {
                                        // loopThrough();

                                        // okDokecky();

                                        okList(j);
                                        listTestVal[j].add(testValue());

                                        // barber = true;
                                      });
                                    }),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    icon: Icon(Icons.account_box_outlined),
                                    onPressed: () {
                                      setState(() {
                                        // k -= 1;
                                        if (kLists[j][0] < 1) {
                                          kLists[j][0] = 0;
                                        } else {
                                          delOkList(j);
                                        }

                                        // Need to handle this please.
                                        // listTestVal.removeAt(
                                        //     listTestVal[j].length - 1);

                                        if (k <= 0) {
                                          clearSum();
                                        }
                                      });
                                    }),
                              ],
                            ),
                          ),
                      ],
                    ),

                    // SingleChildScrollView(
                    //   controller: _scrollController,
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     // mainAxisSize: MainAxisSize.min ,
                    //     // mainAxisAlignment: MainAxisAlignment.center,
                    //     // crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Property(totoControll[1], addedOp),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       for (int j = 0; j < k; j++)
                    //         testValue(firstOperand.toString(),
                    //             secondOperand.toString()),

                    //       // loopThrough(),
                    //       IconButton(
                    //           icon: Icon(Icons.add_circle),
                    //           iconSize: 30,
                    //           // color: Colors.purple,
                    //           onPressed: () {
                    //             setState(() {
                    //               // loopThrough();
                    //               toast.add(_testValueState());
                    //               okDokecky();
                    //               // okList();

                    //               // barber = true;
                    //             });
                    //           }),
                    //       SizedBox(
                    //         width: 20,
                    //       ),
                    //       IconButton(
                    //           icon: Icon(Icons.account_box_outlined),
                    //           onPressed: () {
                    //             setState(() {
                    //               k -= 1;
                    //               if (k <= 0) {
                    //                 clearSum();
                    //               }
                    //             });
                    //           }),
                    //     ],
                    //   ),
                    // ),

                    // ),
                    // YOU CAN DELETE
                    SlideTransition(
                      position: _animation,
                      child: Text('YOU ARE A SUCCESS',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    //testing
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 300,
                          child: Stack(
                            children: <Widget>[
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn,
                                left: _left,
                                top: _top,
                                right: _right,
                                bottom: _bottom,
                                child: Container(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          child: const Text('CLICK ME!'),
                          onPressed: () {
                            setState(() {
                              _left = _first ? 10 : 20;
                              _top = _first ? 70 : 20;
                              _right = _first ? 10 : 20;
                              _bottom = _first ? 70 : 20;

                              _first = !_first;
                            });
                          },
                        ),
                      ],
                    ),
                    // Container(
                    //   child: _getButton(
                    //       text: '=',
                    //       onTap: () {
                    //         setState(() {
                    //           verifyList = true;
                    //           sumIt();
                    //           clearSum();
                    //           sumIt();
                    //         });
                    //       },
                    //       backgroundColor: Colors.orange,
                    //       textColor: Colors.white),
                    // ),
                    // Container(
                    //   child: _getButton(
                    //       text: 'Clear',
                    //       onTap: () {
                    //         setState(() {
                    //           // verifyList = true;
                    //           clearSum();
                    //         });
                    //       },
                    //       backgroundColor: Colors.red,
                    //       textColor: Colors.white),
                    // ),
                    // AnimatedPositioned(
                    //     width: positionSilde ? 50 : 300,
                    //     // bottom: positionSilde?0:0,
                    //     // curve: positionSilde
                    //     //     ? Curves.bounceInOut
                    //     //     : Curves.linearToEaseOut,
                    //     child: Container(
                    //         width: 100,
                    //         height: 60,
                    //         // color: Colors.white,
                    //         // padding: const EdgeInsets.all(16.0),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(13.0),
                    //           border: Border.all(color: Colors.white),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: Colors.black12,
                    //               offset: Offset(2, 2),
                    //               spreadRadius: 2,
                    //               blurRadius: 1,
                    //             ),
                    //           ],
                    //         ),
                    //         child: Center(
                    //           child: Row(
                    //             children: <Widget>[
                    //               Text(
                    //                 firstOperand.toString(),
                    //               ),
                    //             ],
                    //           ),
                    //         )),
                    //     duration: Duration(microseconds: 500))

                    // for (int j = 1; j < n; j++)

                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Column(children: [
                    //         for (int j = 1; j < n; j++)
                    //           Property(totoControll[j], addedOp),
                    //       ]),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Column(
                    //         children: [
                    //           for (int j = 1; j < n; j++)
                    //             testValue(totoControll[j], addedOp),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // )

                    // Container(
                    //   width: 100,
                    //   child: Flexible(
                    //   child: Column(
                    //     children: [
                    //       AmountText(
                    //     'Total Amount: $addTot',
                    //     key: Key('totalAmount'),
                    //   ),
                    //     ],
                    //   ),
                    // ),
                    // )

                    // )
                  ]),
                ),
              )),
              Container(
                alignment: Alignment.bottomCenter,
                // width: 300,
                // height: 100,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: AmountText(
                  'Total : $summing',
                  key: Key('totalAmount'),
                ),
              ),
            ],
          ),
        )

        //           TextFormField(
        //             key: Key("tipPercentage"),
        //             controller: _tipPercentageController,
        //             keyboardType: TextInputType.number,
        //             decoration: InputDecoration(
        //               hintText: 'Enter the Tip Percentage',
        //               labelText: 'Tip Percentage',
        //               labelStyle: TextStyle(
        //                   fontSize: 25,
        //                   letterSpacing: 1,
        //                   fontWeight: FontWeight.bold),
        //               fillColor: Colors.white,
        //               border: new OutlineInputBorder(
        //                 borderRadius: new BorderRadius.circular(20.0),
        //                 borderSide: new BorderSide(),
        //               ),
        //             ),
        //           ),
        //           SizedBox(
        //             height: 20,
        //           ),
        //           // I'm hereeeeeeeeeeeeeeeee
        //           getPapu(),
        //           SizedBox(
        //             height: 25,
        //           ),
        //           Container(
        //             margin: EdgeInsets.all(15),
        //             padding: EdgeInsets.all(15),
        //             decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.all(
        //                 Radius.circular(15),
        //               ),
        //               border: Border.all(color: Colors.white),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Colors.black12,
        //                   offset: Offset(2, 2),
        //                   spreadRadius: 2,
        //                   blurRadius: 1,
        //                 ),
        //               ],
        //             ),
        //             child: Column(
        //               children: [
        //                 AmountText(
        //                   'Tip Amount: ${_getTipAmount()}',
        //                   key: Key('tipAmount'),
        //                 ),
        //                 AmountText(
        //                   'Total Amount: ${_getTotalAmount()}',
        //                   key: Key('totalAmount'),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        );
  }

  @override
  void dispose() {
    _billAmountController.dispose();
    _tipPercentageController.dispose();
    // totoControll.dispose();
    super.dispose();
  }
}

class ColumnLooping extends StatefulWidget {
  final scrollControll;
  final aProperty;
  final aTestValue;
  const ColumnLooping(this.scrollControll, this.aProperty, this.aTestValue);
  @override
  _ColumnLoopingState createState() => _ColumnLoopingState();
}

class _ColumnLoopingState extends State<ColumnLooping> {
  // columnLoop() {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 100,
        child: Column(
      children: [
        SingleChildScrollView(
          controller: widget.scrollControll,
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisSize: MainAxisSize.min ,
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.aProperty,
              SizedBox(
                width: 10,
              ),
              for (int i = 0; i < k; i++) widget.aTestValue,

              // loopThrough(),
              // IconButton(
              //     icon: Icon(Icons.add_circle),
              //     iconSize: 30,
              //     // color: Colors.purple,
              //     onPressed: () {
              //       setState(() {
              //         // loopThrough();

              //         okDokecky();

              //         // barber = true;
              //       });
              //     }),
              // SizedBox(
              //   width: 20,
              // ),
              // IconButton(
              //     icon: Icon(Icons.account_box_outlined),
              //     onPressed: () {
              //       setState(() {
              //         k -= 1;
              //         if (k <= 0) {
              //           clearSum();
              //         }
              //       });
              //     }),
            ],
          ),
        ),
        SizedBox(
          height: 1,
        )
      ],
    ));
  }
}

class AmountText extends StatelessWidget {
  final String text;

  const AmountText(
    this.text, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(text.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
              fontSize: 20)),
    );
  }
}

var barber = false;

List<String> listResults = [];
List<int> listsumOperation = [];
List<int> listFirstOp = [];
List<int> listSecOp = [];
List<List<testValue>> listTestVal = [
  [testValue()]
];
List<List<int>> testingList2D = List.generate(5, (ol) => [0], growable: true);
List<List<int>> bestListFirstOp = [[]];
List<List<int>> bestListSectOp = [[]];
List<List<int>> kLists = [
  [1],
  [1]
];
bool verifyList = false;
int sum = 0;
int summer = 0;
int sumo = 0;
String summa;
int summing = 0;
int lol;
int a;
int z;
int lil = 0;
okList(int plp) {
  kLists[plp][0] += 1;
}

delOkList(int n) {
  kLists[n][0] -= 1;
}

int tab = 1;
tabDockey() => tab += 1;
int col = 1;
int col2 = 0;
colDockey() {
  col += 1;
  col2 += 1;
  // lil += 1;
  // bestListFirstOp = [for (int j = 0; j < col; j++) []];
}

int k = 1;
bool kTruth = false;
okDokecky() {
  k += 1;
  kTruth = true;

  print(listFirstOp);
  print(testingList2D);
  print(bestListFirstOp);
  print(bestListSectOp);
  print(kLists);
}

sumIt() {
  summing = 0;
  for (int l = 0; l < listsumOperation.length; l++) {
    // summer = 0;
    summer += listsumOperation[l];
    summing += listsumOperation[l];
    // summing = sumo - summer;
  }
  // listsumOperation.forEach((element) {
  //   if (element == null) {
  //     element = 0;
  //   } else {
  //     summing += element;
  //   }
  //   // summing = 0;
  // });

  return summing;
}

clearSum() {
  listsumOperation.clear();
}

class Property extends StatefulWidget {
  final controller;
  final calculateF;

  const Property(
    this.controller,
    this.calculateF, {
    Key key,
  }) : super(key: key);

  @override
  _PropertyState createState() => _PropertyState();
}

class _PropertyState extends State<Property> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      // color: Colors.white,
      // padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
      // padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(13.0),
      //   border: Border.all(color: Colors.white),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black12,
      //       offset: Offset(2, 2),
      //       spreadRadius: 2,
      //       blurRadius: 1,
      //     ),
      //   ],
      // ),
      child: TextFormField(
        key: Key("billAmount"),
        controller: widget.controller,
        // keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          hintText: 'Property',
          // labelText: 'Row',
          labelStyle: TextStyle(
              fontSize: 21, letterSpacing: 1, fontWeight: FontWeight.bold),
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(20.0),
            borderSide: new BorderSide(),
          ),
        ),
      ),
    );
  }
}

class testValue extends StatefulWidget {
  // final controller;
  // final calculateF;

  // const testValue(
  //   this.controller,
  //   this.calculateF, {
  //   Key key,
  // }) : super(key: key);

  @override
  _testValueState createState() => _testValueState();
}

class _testValueState extends State<testValue> {
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  double width;

  int resulting = 0;
  int firstOperand = 0;
  String operator;
  int secondOperand = 0;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  numberPressed(int number) {
    setState(() {
      if (resulting != null) {
        resulting = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          resulting = firstOperand + secondOperand;
          break;
        case '-':
          resulting = firstOperand - secondOperand;
          break;
        case '*':
          resulting = firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          resulting = firstOperand ~/ secondOperand;
          break;
      }

      firstOperand = resulting;
      operator = null;
      secondOperand = null;
      resulting = null;
    });
  }

  clear() {
    setState(() {
      resulting = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  Widget _getButton(
      {String text,
      Function onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  String _getDisplayText() {
    if (resulting != null) {
      return '$resulting';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  replicateCalculation() {
    return Material(
        child: Column(children: [
      // ResultDisplay(text: _getDisplayText()),
      Row(
        children: [
          _getButton(text: '7', onTap: () => numberPressed(7)),
          _getButton(text: '8', onTap: () => numberPressed(8)),
          _getButton(text: '9', onTap: () => numberPressed(9)),
          _getButton(
              text: 'x',
              onTap: () {
                operatorPressed('*');
              },
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '4', onTap: () => numberPressed(4)),
          _getButton(text: '5', onTap: () => numberPressed(5)),
          _getButton(text: '6', onTap: () => numberPressed(6)),
          _getButton(
              text: '/',
              onTap: () => operatorPressed('/'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '1', onTap: () => numberPressed(1)),
          _getButton(text: '2', onTap: () => numberPressed(2)),
          _getButton(text: '3', onTap: () => numberPressed(3)),
          _getButton(
              text: '+',
              onTap: () => operatorPressed('+'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1))
        ],
      ),
      Row(
        children: [
          IconButton(
              icon: Icon(Icons.account_box_outlined),
              onPressed: () {
                if (firstOperand == null) {
                  firstOperand = 0;
                } else if (secondOperand == null) {
                  secondOperand = 0;
                }
                listsumOperation.add(sumOperation);
                listFirstOp.add(firstOperand);
                listSecOp.add(secondOperand);

                bestListFirstOp[col2].add(firstOperand);
                bestListSectOp[col2].add(secondOperand);
                // bestListFirstOp.add([]);

                getREsulting();
                Navigator.of(context).pop();

                sumIt();
              }),
          // _getButton(
          //     text: '=',
          //     onTap: calculateResult(),
          //     backgroundColor: Colors.orange,
          //     textColor: Colors.white),
          _getButton(text: '0', onTap: () => numberPressed(0)),
          _getButton(
              text: 'C',
              onTap: clear,
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          _getButton(
              text: '-',
              onTap: () => operatorPressed('-'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
    ]));
  }

  //<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<><>
  //<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<><>
  int displayedText;
  int number2;
  int sumOperation = 0;

  getREsulting() {
    setState(() {
      if (operator == null || secondOperand == null) {
        return;
      }
      setState(() {
        switch (operator) {
          case '+':
            sumOperation = firstOperand + secondOperand;
            break;
          case '-':
            sumOperation = firstOperand - secondOperand;
            break;
          case '*':
            sumOperation = firstOperand * secondOperand;
            break;
          case '/':
            if (secondOperand == 0) {
              return;
            }
            sumOperation = firstOperand ~/ secondOperand;
            break;
        }

        // firstOperand = sumOperation;
        // operator = null;
        // secondOperand = null;
        // sumOperation = null;
      });

      // sumOperation = firstOperand + secondOperand;
    });
  }

  List<int> goTophe = new List(10);

  sumThemUp() {
    for (int i = 0; i < listResults.length; i++) {
      goTophe[i] = 0;
      goTophe[i] = int.parse(listResults[i]);
      sum += goTophe[i];
      summa += listResults[i];
    }
  }

  returnsumOperation() {
    return sumOperation;
  }

  showmePlease() {
    listsumOperation.add(sumOperation);
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: replicateCalculation());
        });
  }

  // int k = 1;
  List<int> listTest = [0];
  @override
  Widget build(BuildContext context) {
    getREsulting();

    // sumThemUp();
    // listResults = [displayedText];
    return Container(
      height: 80,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              showmePlease();
              // listResults.add(48);

              // listResults.add(_getDisplayText());

              print(listResults);
              print(listFirstOp);
              print(listSecOp);

              print(testingList2D);
              // print(goTophe);
              print(sumOperation);
            },
            child: Container(
                width: 100,
                height: 60,
                // color: Colors.white,
                // padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13.0),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        firstOperand.toString(),
                      ),
                    ],
                  ),
                )),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(2, 2),
                    spreadRadius: 2,
                    blurRadius: 1,
                  ),
                ],
              ),
              // color: Colors.white,
              // padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      secondOperand.toString(),
                    ),
                  ],
                ),
              )),
          SizedBox(
            width: 20,
          ),
          // ActionAdded(secondOperand.toString()),
          // for (int i = 1; i < k; i++) testValue("controller", ""),
          // IconButton(
          //     icon: Icon(Icons.add_circle),
          //     iconSize: 30,
          //     // color: Colors.purple,
          //     onPressed: () {
          //       setState(() {
          //         okDokecky();

          //         // barber = true;
          //       });
          //     }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     icon: Icon(Icons.account_box_outlined),
          //     onPressed: () {
          //       setState(() {
          //         k -= 1;
          //       });
          //     }),
          // SizedBox(
          //   width: 20,
          // ),
          // IconButton(
          //     icon: Icon(Icons.account_box_outlined),
          //     onPressed: () {
          //       listsumOperation.add(sumOperation);
          //     }),
          // IconButton(icon: Icon(Icons.account_box_outlined), onPressed: null),
          // IconButton(icon: Icon(Icons.account_box_outlined), onPressed: null)
        ],
      ),
    );
  }
}

// Calculator Sec.Design>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>?..>>
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter basic calculator',
      home: Scaffold(body: Calculation()),
    );
  }
}

class Calculation extends StatefulWidget {
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  double width;

  int resulting;
  int firstOperand;
  String operator;
  int secondOperand;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  numberPressed(int number) {
    setState(() {
      if (resulting != null) {
        resulting = null;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      if (firstOperand == null) {
        firstOperand = 0;
      }
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          resulting = firstOperand + secondOperand;
          break;
        case '-':
          resulting = firstOperand - secondOperand;
          break;
        case '*':
          resulting = firstOperand * secondOperand;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          resulting = firstOperand ~/ secondOperand;
          break;
      }

      firstOperand = resulting;
      operator = null;
      secondOperand = null;
      resulting = null;
    });
  }

  clear() {
    setState(() {
      resulting = null;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  Widget _getButton(
      {String text,
      Function onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      size: width / 4 - 12,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

  String _getDisplayText() {
    if (resulting != null) {
      return '$resulting';
    }
    if (secondOperand != null) {
      return '$firstOperand$operator$secondOperand';
    }
    if (operator != null) {
      return '$firstOperand$operator';
    }
    if (firstOperand != null) {
      return '$firstOperand';
    }
    return '0';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(children: [
      ResultDisplay(text: _getDisplayText()),
      Row(
        children: [
          _getButton(text: '7', onTap: () => numberPressed(7)),
          _getButton(text: '8', onTap: () => numberPressed(8)),
          _getButton(text: '9', onTap: () => numberPressed(9)),
          _getButton(
              text: 'x',
              onTap: () => operatorPressed('*'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '4', onTap: () => numberPressed(4)),
          _getButton(text: '5', onTap: () => numberPressed(5)),
          _getButton(text: '6', onTap: () => numberPressed(6)),
          _getButton(
              text: '/',
              onTap: () => operatorPressed('/'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '1', onTap: () => numberPressed(1)),
          _getButton(text: '2', onTap: () => numberPressed(2)),
          _getButton(text: '3', onTap: () => numberPressed(3)),
          _getButton(
              text: '+',
              onTap: () => operatorPressed('+'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1))
        ],
      ),
      Row(
        children: [
          _getButton(
              text: '=',
              onTap: calculateResult,
              backgroundColor: Colors.orange,
              textColor: Colors.white),
          _getButton(text: '0', onTap: () => numberPressed(0)),
          _getButton(
              text: 'C',
              onTap: clear,
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
          _getButton(
              text: '-',
              onTap: () => operatorPressed('-'),
              backgroundColor: Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
    ]));
  }
}

// operatorPressed(String operator) {}
// numberPressed(int number) {}
// calculateResult() {}
// clear() {}

class ResultDisplay extends StatelessWidget {
  final text;
  const ResultDisplay({@required this.text});
  // final int resulting;
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.infinity,
        // height: 120,
        color: Colors.white,
        child: Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.only(right: 24, bottom: 24),
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 34),
            )));
  }
}

class CalculatorButton extends StatelessWidget {
  CalculatorButton(
      {@required this.label,
      @required this.onTap,
      @required this.size,
      this.backgroundColor = Colors.white,
      this.labelColor = Colors.black});
  final String label;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color labelColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(6),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(1, 1), blurRadius: 2),
              ],
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
              color: backgroundColor),
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
            onTap: onTap,
            child: Center(
                child: Text(
              label,
              style: TextStyle(fontSize: 24, color: labelColor),
            )),
          ), // Label text and other stuff here
        ));
  }
}

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>?..>>
// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><>>>>>>>>>>>>>>>
class BiggerTableData extends StatefulWidget {
  final receiveTableData;
  const BiggerTableData(this.receiveTableData);

  @override
  _BiggerTableDataState createState() => _BiggerTableDataState();
}

class _BiggerTableDataState extends State<BiggerTableData> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Tip Calculator',
              style: TextStyle(color: Colors.black87),
            ),
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.green,
          ),
          body: Container(
            child: widget.receiveTableData,
          )),
    );
  }
}

class TableData extends StatefulWidget {
  final coluLoo;
  final miniTV;

  const TableData(
    this.coluLoo,
    this.miniTV,
  );

  @override
  _TableDataState createState() => _TableDataState();
}

class _TableDataState extends State<TableData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 100,
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            //Property
            widget.coluLoo,
            // SizedBox(
            //   width: 20,
            // ),

            widget.miniTV,
          ])),
    );
  }
}

class MiniTestValue extends StatefulWidget {
  final rowMiniWidget;
  final columnMiniWidget;

  const MiniTestValue(this.columnMiniWidget, this.rowMiniWidget);

  @override
  _MiniTestValueState createState() => _MiniTestValueState();
}

class _MiniTestValueState extends State<MiniTestValue> {
  miniTestWidget(int c, int r) {
    return Row(
      children: [
        // for (int i = 0; i < k; i++)
        Container(
            width: 100,
            height: 60,
            // color: Colors.white,
            // padding: const EdgeInsets.all(16.0),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
              border: Border.all(color: Colors.black),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black12,
              //     offset: Offset(2, 2),
              //     spreadRadius: 2,
              //     blurRadius: 1,
              //   ),
              // ],
            ),
            child: Center(
              child: Row(
                children: <Widget>[
                  Text(
                    bestListFirstOp[c][r].toString(),
                  ),
                ],
              ),
            )),
        // for (int i = 0; i < k; i++)
        // SizedBox(
        //   width: 10,
        // ),
        // for (int i = 0; i < k; i++)
        Container(
            width: 100,
            height: 60,
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
              border: Border.all(color: Colors.black),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black12,
              //     offset: Offset(2, 2),
              //     spreadRadius: 2,
              //     blurRadius: 1,
              //   ),
              // ],
            ),
            // color: Colors.white,
            // padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Row(
                children: <Widget>[
                  // for (int i = 0; i < tab; i++)
                  Text(
                    bestListSectOp[c][r].toString(),
                  ),
                ],
              ),
            )),
        // SizedBox(
        //   width: 10,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return //TestValue
        Container(
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          // miniTestWidget(widget.columnMiniWidget),
          miniTestWidget(widget.columnMiniWidget, widget.rowMiniWidget),
        ],
      ),
    );
  }
}

class MiniProperty extends StatefulWidget {
  final controller;
  const MiniProperty(this.controller);

  @override
  _MiniPropertyState createState() => _MiniPropertyState();
}

class _MiniPropertyState extends State<MiniProperty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // color: Colors.green,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      width: 150,
      height: 60,
      child: Text(
        widget.controller.toString(),
        style: TextStyle(
            fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Testing saving files on disk. Awesome
class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}

class FlutterDemo extends StatefulWidget {
  final CounterStorage storage;

  FlutterDemo({Key key, @required this.storage}) : super(key: key);

  @override
  _FlutterDemoState createState() => _FlutterDemoState();
}

class _FlutterDemoState extends State<FlutterDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // Write the variable as a string to the file.
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing Files')),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//////////////////////////////////////////////
class SpeechRecoTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SpeechScreen(),
    );
  }
}

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  String checkingSomeStuff() {
    if (_text.toUpperCase().contains("OPEN YOUTUBE")) {
      print("success chris success");
      openYoutube();
    }
    return _text;
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: () {
            _listen();

            checkingSomeStuff();
          },
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          listenFor: Duration(seconds: 20),
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
        // checkingSomeStuff();
      }
    } else {
      setState(() => _isListening = false);
      // checkingSomeStuff();
      _speech.stop();
    }
  }

  openYoutube() async {
    await LaunchApp.openApp(
        androidPackageName: 'com.google.android.youtube',
        // iosUrlScheme: 'pulsesecure://',
        // appStoreLink:
        //     'itms-apps://itunes.apple.com/us/   app/pulse-secure/id945832041',
        openStore: false);
  }

  openWhatsapp() async {
    await LaunchApp.openApp(
        androidPackageName: 'com.whatsapp',
        // iosUrlScheme: 'pulsesecure://',
        // appStoreLink:
        //     'itms-apps://itunes.apple.com/us/   app/pulse-secure/id945832041',
        openStore: false);
  }
}

///
///
///
///
//Special Other Speech Recognition
// class VoiceHome extends StatefulWidget {
//   @override
//   _VoiceHomeState createState() => _VoiceHomeState();
// }

// class _VoiceHomeState extends State<VoiceHome> {
//   SpeechRecognition _speechRecognition;
//   bool _isAvailable = false;
//   bool _isListening = false;

//   String resultText = "";

//   @override
//   void initState() {
//     super.initState();
//     initSpeechRecognizer();
//   }

//   void initSpeechRecognizer() {
//     _speechRecognition = SpeechRecognition();

//     _speechRecognition.setAvailabilityHandler(
//       (bool result) => setState(() => _isAvailable = result),
//     );

//     _speechRecognition.setRecognitionStartedHandler(
//       () => setState(() => _isListening = true),
//     );

//     _speechRecognition.setRecognitionResultHandler(
//       (String speech) => setState(() => resultText = speech),
//     );

//     _speechRecognition.setRecognitionCompleteHandler(
//       () => setState(() => _isListening = false),
//     );

//     _speechRecognition.activate().then(
//           (result) => setState(() => _isAvailable = result),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 FloatingActionButton(
//                   child: Icon(Icons.cancel),
//                   mini: true,
//                   backgroundColor: Colors.deepOrange,
//                   onPressed: () {
//                     if (_isListening)
//                       _speechRecognition.cancel().then(
//                             (result) => setState(() {
//                               _isListening = result;
//                               resultText = "";
//                             }),
//                           );
//                   },
//                 ),
//                 FloatingActionButton(
//                   child: Icon(Icons.mic),
//                   onPressed: () {
//                     if (_isAvailable && !_isListening)
//                       _speechRecognition
//                           .listen(locale: "en_US")
//                           .then((result) => print('$result'));
//                   },
//                   backgroundColor: Colors.pink,
//                 ),
//                 FloatingActionButton(
//                   child: Icon(Icons.stop),
//                   mini: true,
//                   backgroundColor: Colors.deepPurple,
//                   onPressed: () {
//                     if (_isListening)
//                       _speechRecognition.stop().then(
//                             (result) => setState(() => _isListening = result),
//                           );
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               decoration: BoxDecoration(
//                 color: Colors.cyanAccent[100],
//                 borderRadius: BorderRadius.circular(6.0),
//               ),
//               padding: EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 12.0,
//               ),
//               child: Text(
//                 resultText,
//                 style: TextStyle(fontSize: 24.0),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//Special Other Speech Recognition
