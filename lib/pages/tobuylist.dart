import 'package:flutter/material.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/services/models.dart';

class ToBuyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream: Firestore.instance
            .collection('productos')
            .where('estado', isEqualTo: 'faltante')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircleAvatar();
          // Producto producto = Producto.fromDS(snapshot.data.documents[0]);

          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            shrinkWrap: true,
            itemBuilder: (context, index) => ItemCard(
              producto: Producto.fromDS(snapshot.data.documents[index]),
              comprado: false,
            ),
          );
        });
  }
}
