import 'package:flutter/material.dart';

class ToBuyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: 20,
      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Icon(Icons.restaurant_menu),
          title: Text('Producto a comprar'),
          trailing: Icon(Icons.check_box),
        ),
      ),
    );
  }
}
