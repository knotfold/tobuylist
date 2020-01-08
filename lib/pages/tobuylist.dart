import 'package:flutter/material.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/services/models.dart';

class ToBuyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: Firestore.instance.collection('productos').where('estado', isEqualTo: 'faltante' ).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return const CircleAvatar();
        // Producto producto = Producto.fromDS(snapshot.data.documents[0]);
       
        return ListView.builder(
        itemCount: snapshot.data.documents.length,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        shrinkWrap: true,
        itemBuilder: (context, index) => ItemCard(producto: Producto.fromDS(snapshot.data.documents[index]),),
      );
      }
    );
  }
}

class ItemCard extends StatelessWidget {
  final Producto producto;
  const ItemCard({
    Key key,
    this.producto
  }) : super(key: key,); 

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileTheme(
        iconColor: secondaryColor,
        selectedColor: primaryColor,
        style: ListTileStyle.drawer,
        child: ExpansionTile(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Lugar: ${producto.lugar}'),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => producto.ref.updateData({
                        'estado' : 'comprado'
                      }),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.check_box, size: 18,),
                          SizedBox(width: 5,),
                          Text('Comprado'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
          leading: Icon(
            Icons.restaurant_menu,
          ),
          title: Text('${producto.nombre}'),
        ),
      ),
    );
  }
}
