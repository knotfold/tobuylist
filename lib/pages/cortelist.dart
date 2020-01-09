import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/services/services.dart';
import 'package:tobuylist/shared/shared.dart';
import 'package:tobuylist/pages/pages.dart';

class CorteList extends StatelessWidget{
  final DocumentReference ref;

  CorteList({this.ref});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: ref.collection('cortes').snapshots(),
      builder: (context,snapshots) {
        if(!snapshots.hasData) return const CircularProgressIndicator();
        print(snapshots.data.documents.length);
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          itemCount: snapshots.data.documents.length,
          itemBuilder: (context,index) => Card(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(snapshots.data.documents[index].documentID, style: TextStyle(fontSize: 25), textAlign: TextAlign.center,),
                      Text( 'Total: \$' +snapshots.data.documents[index]['total'].toString(), style: TextStyle(fontSize: 25), textAlign: TextAlign.center,)
                    ],
                  ),
                  
                  BoughtList(ref: snapshots.data.documents[index].reference,)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}