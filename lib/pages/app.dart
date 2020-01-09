import 'package:flutter/material.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:tobuylist/pages/pages.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => null,
        icon: Icon(Icons.add_box),
        label: Text('Añadir Producto'),
      ),
      appBar: AppBar(
     
        actions: <Widget>[
          IconButton(
            onPressed: () => null,
            icon: Icon(Icons.assignment),
          ),
        ],
        title: Text('ToBuyList'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
            
              ToBuyList()
            ],
          ),
        ),
      )
    );
  }
}
