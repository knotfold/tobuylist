import 'package:flutter/material.dart';
import 'package:tobuylist/shared/colors.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = '';

  Map<String, dynamic> loginMap = {'user': null, 'password': null};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLight,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(4.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 75.0,
                ),
                Text(
                  'Iniciar Sesión',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: primaryText),
                ),
                SizedBox(
                  height: 75.0,
                ),
                Card(
                  elevation: 9.0,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: 'Usuario',
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        RaisedButton(
                          onPressed: () => null,
                          textColor: primaryDark,
                          elevation: 9.0,
                          highlightElevation: 6.0,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                          ),
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
