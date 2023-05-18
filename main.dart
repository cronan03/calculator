import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:flutter/material.dart';


void main()=> runApp(MaterialApp(
  home: Calculator(),
));

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  var input ='';
  var output = '';
  var operation = '';
  var hidein = false;
  var outsize=48.0;
  buttonfxn (value){

    if(value=='AC'){
      input='';
      output='';
    }
    else if(value=='>'){
      if(input.isNotEmpty)
      input=input.substring(0,input.length-1);
    }
    else if(value=='='){
      if (input.isNotEmpty) {
        var userinput;
        userinput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression exp = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalValue = exp.evaluate(EvaluationType.REAL, cm);
        output=finalValue.toString();
        if(output.endsWith("0"))
          output = output.substring(0,output.length-2);
        hidein = true;
        input=output;
        outsize=58;
      }
    }
    else{
      input = input + value;
      hidein = false;
      outsize=48;

    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: Container(
            color: Colors.grey[800],
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hidein ? "" : "$input",
                  style: TextStyle(
                    fontSize: outsize,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "$output",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white.withOpacity(0.5)
                  ),
                ),
                SizedBox(height: 20)
              ],
            ),
          )),
          //button
          Row(
            children: [
              Button(text: "AC", butcolor: Colors.red),
              Button(text: ">"),
              Button(text: "%"),
              Button(text: "/")
            ],
          ),
          Row(
            children: [
              Button(text: "7"),
              Button(text: "8"),
              Button(text: "9"),
              Button(text: "x")
            ],
          ),
          Row(
            children: [
              Button(text: "4"),
              Button(text: "5"),
              Button(text: "6"),
              Button(text: "-")
            ],
          ),
          Row(
            children: [
              Button(text: "1"),
              Button(text: "2"),
              Button(text: "3"),
              Button(text: "+")
            ],
          ),
          Row(
            children: [
              Button(text: ""),
              Button(text: "0"),
              Button(text: "."),
              Button(text: "=", butcolor: Colors.deepPurpleAccent)
            ],
          )



        ],
      ),
    );

  }
  Widget Button({text,i, tcolor = Colors.white , butcolor = Colors.transparent}){

    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonfxn(text),
        child: Text(
          "$text",
          style: TextStyle(
              color: tcolor,
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            shape: CircleBorder(eccentricity: 0.0),
            backgroundColor: butcolor
        ),
      ),
    );

  }
}
