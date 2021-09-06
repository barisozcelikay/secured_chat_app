import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secured_chat_app/Widgets/customalert.dart';
import 'package:secured_chat_app/Widgets/customsnackbar.dart';

class Login extends StatefulWidget {
  Login({required Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  ///Input controller for id.
  final idController = TextEditingController();

  ///Input controller for surname.
  final surnameController = TextEditingController();

  ///Input controller for access code.
  final accessController = TextEditingController();

  /// ID hide/show key.
  bool obscureID = true;

  /// Access code hide/show key.
  bool obscureAccess = true;

  /// Rememmber me yes / no key.
  bool rememberMe = false;

  //Is waiter visible or not
  bool iswaiterVisible = false;

  ///Form key.
  final _formKey = GlobalKey<FormState>();

  /// Load event.
  void initState() {
    super.initState();
    // Auto login
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Tooltip(
                        child: SizedBox(
                            width: 32,
                            height: 32,
                            child: Image.asset('images/YILDIZ.png')),
                        message: 'Logo',
                      )),
                  Expanded(
                    child: Tooltip(
                      message: 'Havelsan Chat',
                      child: Text(
                        'Havelsan Chat',
                      ),
                    ),
                  )
                ],
              )),
          body: Stack(
            children: [
              Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        constraints: BoxConstraints(
                          maxWidth: 400,
                          minWidth: 300,
                          minHeight: 300,
                        ),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(color: Colors.black54, width: 2),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[350]!.withOpacity(0.5)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Tooltip(
                                  message: 'Giriş Logo',
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: Theme.of(context).accentColor),
                                      child: Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.signInAlt,
                                          color: Colors.black45,
                                          size: 48,
                                        ),
                                      ))),
                            ),
                            Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Tooltip(
                                      message: 'T.C. Kimlik No',
                                      child: TextFormField(
                                        controller: idController,
                                        // The validator receives the text that the user has entered.
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              int.tryParse(value) == null ||
                                              value.length != 11) {
                                            return 'Lütfen T.C Kimlik No giriniz.';
                                          }
                                          return null;
                                        },
                                        obscureText: obscureID,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLength: 11,
                                        keyboardType: TextInputType.number,

                                        decoration: InputDecoration(
                                          icon: FaIcon(
                                            FontAwesomeIcons.idCardAlt,
                                            size: 20,
                                          ),
                                          labelText: 'T.C. Kimlik No',
                                          suffixIcon: Tooltip(
                                            message: 'T.C. Kimlik No Göster',
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    obscureID = !obscureID;
                                                  });
                                                },
                                                icon: obscureID
                                                    ? FaIcon(
                                                        FontAwesomeIcons
                                                            .solidEyeSlash,
                                                        size: 18,
                                                      )
                                                    : FaIcon(
                                                        FontAwesomeIcons
                                                            .solidEye,
                                                        size: 18,
                                                      )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Tooltip(
                                      message: 'Erişim Kodu',
                                      child: TextFormField(
                                        controller: accessController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Lütfen erişim kodunuzu giriniz.';
                                          }
                                          return null;
                                        },
                                        obscureText: obscureAccess,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          icon: FaIcon(
                                            FontAwesomeIcons.key,
                                            size: 20,
                                          ),
                                          labelText: 'Erişim Kodu',
                                          suffixIcon: Tooltip(
                                            message: 'Erişim Kodu Göster',
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscureAccess =
                                                      !obscureAccess;
                                                });
                                              },
                                              icon: obscureAccess
                                                  ? FaIcon(
                                                      FontAwesomeIcons
                                                          .solidEyeSlash,
                                                      size: 18,
                                                    )
                                                  : FaIcon(
                                                      FontAwesomeIcons.solidEye,
                                                      size: 18,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Tooltip(
                                      message: 'Soyad',
                                      child: TextFormField(
                                        controller: surnameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Lütfen soyadınızı giriniz.';
                                          }
                                          return null;
                                        },
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          icon: FaIcon(
                                            FontAwesomeIcons.userAlt,
                                            size: 20,
                                          ),
                                          labelText: 'Soyad',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              key: _formKey,
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Beni Hatırla'),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Tooltip(
                                          message:
                                              'Beni Hatırla: ${rememberMe ? 'Evet' : 'Hayır'}',
                                          child: Switch(
                                            onChanged: (bool value) {
                                              setState(() {
                                                rememberMe = value;
                                                print(
                                                    'Remember Me: $rememberMe');
                                              });
                                            },
                                            value: rememberMe,
                                          ),
                                        ))
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Tooltip(
                                  message: 'Giriş Yap',
                                  child: ElevatedButton(
                                    onPressed: () => null,
                                    child: Text('Giriş Yap',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Tooltip(
                                    message:
                                        'Berk Babadoğan, © ${DateTime.now().year}',
                                    child: Text(
                                        'Berk Babadoğan, ©  ${DateTime.now().year}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey[900])))),
                          ],
                        ),
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async => false);
  }
}
