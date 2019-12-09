import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Created by liSen on 2019/12/7 15:00.
/// @author liSen < 453354858@qq.com >

class PWEditField extends StatefulWidget {
  ///所有密码框输入完成后监听 Listen after all password boxes are entered
  ///
  final ValueChanged<String> onInputDone;

  final ValueChanged<String> onChanged;

  ///密码框数量 Number of password boxes
  ///
  final int textFieldCount;

  ///密码框宽度 Password box width
  ///
  final double textFieldWidth;

  ///密码框高度 Password box height
  ///
  final double textFieldHeight;

  ///密码框之间的间距 Space between password boxes
  ///
  final double textFieldSpace;

  ///以下是TextField 原有属性 Following are the original TextField properties
  ///
  final bool autoFocus;
  final bool obscureText;
  final TextStyle textStyle;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final BoxDecoration focusDecoration;
  final BoxDecoration unFocusDecoration;
  final TextEditingController controller;

  /// 只能输入数字 Only numbers can be entered
  /// inputFormatters = [WhitelistingTextInputFormatter(RegExp("[0-9]")),]

  PWEditField({
    @required this.textFieldCount,
    this.textFieldWidth = 30,
    this.textFieldHeight = 30,
    this.textFieldSpace = 3,
    this.autoFocus = false,
    this.obscureText = true,
    this.textStyle = const TextStyle(
      fontSize: 12,
      color: Colors.black54,
    ),
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    Decoration focusDecoration,
    Decoration unFocusDecoration,
    this.onInputDone,
    this.onChanged,
    TextEditingController controller,
  })  : focusDecoration = focusDecoration ??
            BoxDecoration(
              border: Border.all(color: Colors.blue, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
        unFocusDecoration = unFocusDecoration ??
            BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
        controller = controller == null ? TextEditingController() : controller;

  @override
  State<StatefulWidget> createState() {
    return PWEditFieldState();
  }
}

class PWEditFieldState extends State<PWEditField> {
  FocusNode _focusNode = FocusNode();
  int _currentIndex = -1;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.autoFocus ? 0 : -1;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _currentIndex = -1;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = widget.textFieldCount * widget.textFieldWidth +
        widget.textFieldCount * widget.textFieldSpace * 2;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Stack(
        children: <Widget>[
          getTextField(),
          Container(
            width: w,
            height: widget.textFieldHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getChildren(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> list = [];
    for (int i = 0; i < widget.textFieldCount; i++) {
      list.add(getChild(i));
    }
    return list;
  }

  Widget getChild(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.textFieldSpace),
      child: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
          FocusScope.of(context).requestFocus(_focusNode);
          _currentIndex = widget.controller.text.length;
          setState(() {});
        },
        child: Container(
          decoration: _currentIndex == index
              ? widget.focusDecoration
              : widget.unFocusDecoration,
          width: widget.textFieldWidth,
          height: widget.textFieldHeight,
          child: Center(
            child: getTextWidget(index),
          ),
        ),
      ),
    );
  }

  Widget getTextWidget(int index) {
    String data = "";
    String text = widget.controller.text;
    if (text.length > index) {
      data = widget.obscureText ? "●" : text.substring(index, index + 1);
    }
    return Text(
      data,
      maxLines: 1,
      style: widget.textStyle,
      textAlign: TextAlign.center,
    );
  }

  Widget getTextField() {
    return Container(
      width: 0,
      height: 0,
      child: TextField(
        enableInteractiveSelection: false,
        focusNode: _focusNode,
        showCursor: false,
        autofocus: widget.autoFocus,
        controller: widget.controller,
        maxLength: widget.textFieldCount,
        maxLines: 1,
        obscureText: widget.obscureText,
        style: widget.textStyle,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "",
          contentPadding: EdgeInsets.only(
            top: 0,
            bottom: 0,
            left: 2,
          ),
        ),
        textAlign: TextAlign.center,
        onChanged: (String text) {
          if (widget.onChanged != null) {
            widget.onChanged(text);
          }
          _currentIndex = text.length;
          setState(() {});
          if (widget.onInputDone != null &&
              text.length == widget.textFieldCount) {
            widget.onInputDone(widget.controller.text);
            widget.controller.text = "";
            _focusNode.unfocus();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
