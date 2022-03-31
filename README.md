# [pw_edit_field](https://github.com/lisen87/pw_edit_field)

flutter 密码输入框

flutter password input box

> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
pw_edit_field: ^2.0.0
```

```dart
import 'package:pw_edit_field/pw_edit_field.dart';
```

```dart
///输入完成后自动关闭输入法，并返回输入值
///Automatically close the input method after the input is completed, and return the input value

 PWEditField(
    textFieldCount: 6,
    onInputDone: (pw){
      
    },
  ),
  
  ///输入后，通过controller.text获取输入值
  ///After input, get the input value through controller.text
  
  PWEditField(
     textFieldCount: 3,
     controller: _controller,
   ),
  
```
![](https://github.com/lisen87/pw_edit_field/blob/master/screenshots/screenshot_001.png)
