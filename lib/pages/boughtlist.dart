import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:tobuylist/services/services.dart';

class BoughtList extends StatelessWidget {
  final DocumentReference ref;

  BoughtList({this.ref});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: ref
          .collection('productos')
          .where('estado', isEqualTo: 'comprado')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return const Center(
            child: CircularProgressIndicator(),
          );

        return ListView.builder(
          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          itemCount: snapshot.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ItemCard(
            producto: Producto.fromDS(snapshot.data.documents[index]),
            comprado: true,
          ),
        );
      },
    );
  }
}
