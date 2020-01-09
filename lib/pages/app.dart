import 'package:flutter/material.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:tobuylist/pages/pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class App extends StatefulWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> _widgetOptions = <Widget>[
    ToBuyList(),
    Text(
      'Index 1: Business',
      style: App.optionStyle,
    ),
    Text(
      'Index 2: School',
      style: App.optionStyle,
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        // bottomNavigationBar: MyBottomNavBar(), Sin Uso
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          elevation: 10,
          onPressed: () => _showAddDialog(),
          icon: Icon(Icons.add_box),
          label: Text('Añadir'),
        ),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/boughtlist'),
              icon: Icon(Icons.assignment),
            ),
          ],
          title: Text('ToBuyList'),
        ),
        body: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[ToBuyList()],
            ),
          ),
        ));
  }

  _showAddDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Map<String, dynamic> addMap = {
      'cantidad': null,
      'nombre': null,
      'lugarcompra': null
    };

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Agregar Producto'),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'El campo nombre debe de ser llenado';
                        }
                      },
                      onSaved: (value) => addMap['nombre'] = value,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'El campo cantidad debe de ser llenado';
                        }
                      },
                      onSaved: (value) => addMap['cantidad'] = int.parse(value),
                      decoration: InputDecoration(labelText: 'Cantidad'),
                    ),
                    TextFormField(
                      onSaved: (value) => addMap['lugarcompra'] = value,
                      decoration: InputDecoration(labelText: '¿Dónde Comprar?'),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'REGRESAR',
                    style: TextStyle(color: secondaryColor),
                  ),
                  onPressed: () => Navigator.of(context).pop()),
              RaisedButton(
                child: Text('AÑADIR'),
                onPressed: () {
                  if (!formKey.currentState.validate()) {
                    return;
                  }

                  formKey.currentState.save();

                  Firestore.instance
                      // .collection('megacortes')
                      // .document('asseburgvera${DateTime.now().year}')
                      // .collection('cortes')
                      // .document('${DateTime.now().month}')
                      .collection('productos')
                      .add({
                    'cantidad': addMap['cantidad'],
                    'nombre': addMap['nombre'],
                    'lugarcompra': addMap['lugarcompra'],
                    'estado': 'faltante'
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
