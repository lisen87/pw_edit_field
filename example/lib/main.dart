import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pw_edit_field/pw_edit_field.dart';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 200,),

              GestureDetector(
                  onTap: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
                          return CupertinoAlertDialog(
                            content: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(4))),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(height: 200,color: Colors.teal,),
                                    Container(
                                      child: Material(child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        padding:EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
                                          child: PWEditField(textFieldCount: 5,controller: _controller,))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });

                  },
                  child: Text("密码 ：" + pw)),
              SizedBox(
                height: 8,
              ),
              PWEditField(
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
              PWEditField(
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
              PWEditField(
              textFieldCount: 6,
              onInputDone: (pw){
                this.pw = pw;
                setState(() {
                });
              },
            ),
              PWEditField(
              textFieldCount: 3,
              controller: _controller,
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PWEditField(
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
      ),
    );
  }
}
