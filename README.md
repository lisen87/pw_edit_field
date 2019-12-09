# [pw_edit_field](https://github.com/lisen87/pw_edit_field)

flutter 密码输入框

flutter password input box

> Supported  Platforms
> * Android
> * iOS

## How to Use

```yaml
# add this line to your dependencies
pw_edit_field: ^1.0.0
```

```dart
import 'package:pw_edit_field/pw_edit_field.dart';
```

```dart
 PWEditField(
    textFieldCount: 6,
    onInputDone: (pw){
      this.pw = pw;
      setState(() {});
    },
  ),
```
![](https://github.com/lisen87/pw_edit_field/blob/master/screenshots/screenshot_001.png)
