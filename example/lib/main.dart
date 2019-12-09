import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pw_edit_field/PasswordWidget.dart';

import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String pw = "";
  FocusNode _focusNode = FocusNode();

  String _message;

  //虚拟
  void _handleKeyEvent(RawKeyEvent event) {
    setState(() {
      if (event.logicalKey == LogicalKeyboardKey.keyQ) {
        _message = 'Pressed the "Q" key!';
      } else {
        if (kReleaseMode) {
          _message =
              'Not a Q: Key label is "${event.logicalKey.keyLabel ?? '<none>'}"';
        } else {
          // This will only print useful information in debug mode.
          _message = 'Not a Q: Pressed ${event.logicalKey.debugName}';
        }
      }
      print(_message);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

//●
            TextField(
            ),
            Text("密码 ：" + pw),
            SizedBox(
              height: 8,
            ),
            PasswordWidget(
              textFieldCount: 8,
              textFieldSpace: 5,
              textFieldWidth: 30,
              textFieldHeight: 30,
              obscureText: false,
              textStyle: TextStyle(fontSize: 18),
              keyboardType: TextInputType.number,
              inputFormatters : [WhitelistingTextInputFormatter(RegExp("[0-9]")),],
              focusDecoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.teal, width: 2)),
              ),
              unFocusDecoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.red, width: 2)),
              ),
              onInputDone: (pw) {
                this.pw = pw;
                setState(() {});
              },
            ),

            SizedBox(
              height: 8,
            ),
            PasswordWidget(
              textFieldCount: 6,
              textFieldWidth: 40,
              textFieldHeight: 40,
              inputFormatters : [WhitelistingTextInputFormatter(RegExp("[0-9]")),],
              autoFocus: true,
              onInputDone: (pw) {
                this.pw = pw;
                setState(() {
//                  _text.data = pw;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
          PasswordWidget(
            textFieldCount: 6,
            onInputDone: (pw){
              this.pw = pw;
              setState(() {});
            },
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordWidget(
                textFieldCount: 8,
                textFieldSpace: 10,
                textFieldWidth: 40,
                textFieldHeight: 20,
                obscureText: false,
                textStyle: TextStyle(fontSize: 15),
                keyboardType: TextInputType.visiblePassword,
                focusDecoration: BoxDecoration(
                  border: Border.all(color: Colors.teal, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                unFocusDecoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                onInputDone: (pw) {
                  this.pw = pw;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
