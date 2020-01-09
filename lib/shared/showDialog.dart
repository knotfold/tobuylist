import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    showDialog(
     context:context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Verifique los campos en rojo'),
            actions: <Widget>[
              FlatButton(
                  child: Text('REGRESAR'),
                  onPressed: () => Navigator.of(context).pop())
            ],
          );
        });
  }
}
