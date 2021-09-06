import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secured_chat_app/Widgets/customalert.dart';

///Custom message snackbar class.
///Issue: https://github.com/flutter/flutter/issues/84263
class CustomSnackBar extends SnackBar {
  /// Constructor of custom snackbar. [message] is message, [type] is alert type [context] is context

  CustomSnackBar(
      {required Key key,
      required this.message,
      required this.type,
      required this.context})
      : super(
          key: key,
          // margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          // elevation: 10,
          // padding: EdgeInsets.all(10),
          // behavior: SnackBarBehavior.floating,
          behavior: SnackBarBehavior.fixed,

          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20),
          //     side: BorderSide(color: Color.fromRGBO(52, 52, 52, 0.5))),
          // backgroundColor: (() {
          //   if (type == AlertType.Error) {
          //     return Colors.red[700]!.withOpacity(0.7);
          //   } else
          //     return type == AlertType.Warning
          //         ? Colors.orange[700]!.withOpacity(0.7)
          //         : Colors.green[700]!.withOpacity(0.7);
          // }()),
          backgroundColor: (() {
            return type == AlertType.Error
                ? Colors.red[700]!
                : type == AlertType.Warning
                    ? Colors.orange[700]!
                    : Colors.green[700]!;
          }()),
          content: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tooltip(
                    message: 'Alert icon.',
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.blueGrey[700],
                      ),
                      child: FaIcon(
                        (() {
                          if (type == AlertType.Error) {
                            return FontAwesomeIcons.exclamationCircle;
                          } else
                            return type == AlertType.Warning
                                ? FontAwesomeIcons.exclamationTriangle
                                : FontAwesomeIcons.checkCircle;
                        }()),
                        size: 28,
                        color: Colors.white,
                      ),
                    )),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  child: Tooltip(
                    message: message,
                    child: Text(message,
                        style: (() {
                          return type == AlertType.Warning
                              ? Theme.of(context).textTheme.bodyText2
                              : Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white);
                        }())),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tooltip(
                    message: 'Kapat',
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.times,
                        color: Colors.white.withOpacity(0.6),
                        size: 20,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    )),
              ),
            ],
          ),
        );

  /// Message.
  final String message;

  ///Alert type
  final AlertType type;

  final BuildContext context;
}
