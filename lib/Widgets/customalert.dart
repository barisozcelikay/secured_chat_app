import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

///Custom mmessage dialog class.
class CustomAlert extends AlertDialog {
  ///Custom alert. [message] is alert message, [title] is alert title, [buttonname] is button name, [type] is alert type.
  CustomAlert(
      {required Key key,
      required this.message,
      required this.customTitle,
      required this.buttonName,
      required this.type})
      : super(key: key);

  /// Message.
  final String message;

  /// Title
  final String customTitle;

  /// Button name.
  final String buttonName;

  ///Alert type
  final AlertType type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Tooltip(
        message: customTitle,
        child: Text(customTitle),
      ),
      titlePadding: EdgeInsets.fromLTRB(20, 20, 0, 20),
      contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (() {
                      if (type == AlertType.Error) {
                        return Colors.red[700];
                      } else if (type == AlertType.Warning) {
                        return Colors.orange[700];
                      } else {
                        return Colors.green[700];
                      }
                    }())),
                child: Tooltip(
                    message: 'Alert icon.',
                    child: FaIcon(
                      (() {
                        if (type == AlertType.Error) {
                          return FontAwesomeIcons.exclamationCircle;
                        } else if (type == AlertType.Warning) {
                          return FontAwesomeIcons.exclamationTriangle;
                        } else {
                          return FontAwesomeIcons.checkCircle;
                        }
                      }()),
                      color: Colors.white,
                      size: (() {
                        return type == AlertType.Warning ? 36.0 : 48.0;
                      }()),
                    )),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.center,
              ),
              Tooltip(
                message: message,
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Tooltip(
            message: '$buttonName ',
            child: Text(
              '$buttonName',
              style: TextStyle(
                  color: (() {
                if (type == AlertType.Error) {
                  return Colors.red[700];
                } else if (type == AlertType.Warning) {
                  return Colors.orange[700];
                } else {
                  return Colors.green[700];
                }
              }())),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

//Alert type Enum
enum AlertType {
  /// Error
  Error,

  ///Warning
  Warning,

  ///Info
  Info
}
