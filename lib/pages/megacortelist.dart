import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/pages/pages.dart';
import 'package:tobuylist/services/services.dart';
import 'package:tobuylist/shared/shared.dart';

class MegaCorteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('boughtList'),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('megacortes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          snapshot.data.documents[index]['año'],
                          style: TextStyle(fontSize: 30, color: primaryColor),
                        ),
                        Text(
                          'Total: \$' + snapshot.data.documents[index]['total'].toString(),
                          style: TextStyle(fontSize: 30, color: primaryColor),
                        ),
                      ],
                    ),
                    CorteList(
                      ref: snapshot.data.documents[index].reference,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
