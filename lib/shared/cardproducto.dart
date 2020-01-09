import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tobuylist/services/services.dart';
import 'shared.dart';

class ItemCard extends StatelessWidget {
  final Producto producto;
  final bool comprado;
  const ItemCard({Key key, this.producto, this.comprado})
      : super(
          key: key,
        );

  Future acceptDialog(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Map<String, dynamic> addMap = {
      'precio': null,
      'cantidad': null,
      'estado': null,
      'fecha': null,
      'nombre': producto.nombre,
      'lugarcompra': producto.lugar,
      'total': null,
    };
    int cantidad = 0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar compra de producto'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Al hacer click en Aceptar confirma que ya cuenta con este producto en su disposición',
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText: 'Precio',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (value) => addMap['precio'] = int.parse(value),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Llenar el campo precio';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on),
                    labelText:
                        'Cantidad (Cantidad solicitada: ${producto.cantidad})',
                  ),
                  keyboardType: TextInputType.numberWithOptions(),
                  onSaved: (value) => addMap['cantidad'] = int.parse(value),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Llenar el campo cantidad';
                    }
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(color: secondaryColor),
              ),
            ),
            RaisedButton(
              child: Text('Aceptar'),
              onPressed: () async {
                if (!formKey.currentState.validate()) {
                  return;
                }
                formKey.currentState.save();
                cantidad = producto.cantidad - addMap['cantidad'];
                addMap['fecha'] = DateTime.now();

                var query2 = await Firestore.instance
                    .collection('megacortes')
                    .document('asseburgvera${DateTime.now().year}')
                    .get();

                if (cantidad <= 0) {
                  addMap['total'] = addMap['precio'] * addMap['cantidad'];
                  addMap['estado'] = 'comprado';

                  // String value = query.data['total'] ?? '';
                  if (!query2.exists) {
                    await Firestore.instance
                        .collection('megacortes')
                        .document('asseburgvera${DateTime.now().year}')
                        .setData({
                      'total': addMap['total'],
                      'año': DateTime.now().year.toString()
                    });
                  } else {
                    await Firestore.instance
                        .runTransaction((transactionHandler) async {
                      DocumentSnapshot freshSnap = await transactionHandler.get(
                          Firestore.instance
                              .collection('megacortes')
                              .document('asseburgvera${DateTime.now().year}'));
                      if (freshSnap.exists) {
                        await transactionHandler.update(freshSnap.reference, {
                          'total': (freshSnap['total'] == null
                                  ? 0
                                  : freshSnap['total']) +
                              addMap['total']
                        });
                      }
                    });
                  }

                  var query = await Firestore.instance
                      .collection('megacortes')
                      .document('asseburgvera${DateTime.now().year}')
                      .collection('cortes')
                      .document('${numberToMonth(DateTime.now().month)}')
                      .get();
                  if (!query.exists) {
                    await Firestore.instance
                        .collection('megacortes')
                        .document('asseburgvera${DateTime.now().year}')
                        .collection('cortes')
                        .document('${numberToMonth(DateTime.now().month)}')
                        .setData({'total': addMap['total']});
                  } else {
                    await Firestore.instance
                        .runTransaction((transactionHandler) async {
                      DocumentSnapshot freshSnap = await transactionHandler.get(
                          Firestore.instance
                              .collection('megacortes')
                              .document('asseburgvera${DateTime.now().year}')
                              .collection('cortes')
                              .document(
                                  '${numberToMonth(DateTime.now().month)}'));
                      if (freshSnap.exists) {
                        await transactionHandler.update(freshSnap.reference, {
                          'total': (freshSnap['total'] == null
                                  ? 0
                                  : freshSnap['total']) +
                               addMap['total']
                        });
                      }
                    });
                  }

                  Firestore.instance
                      .collection('megacortes')
                      .document('asseburgvera${DateTime.now().year}')
                      .collection('cortes')
                      .document('${numberToMonth(DateTime.now().month)}')
                      .collection('productos')
                      .add(addMap);
                  producto.ref.delete();
                } else {
                  addMap['total'] = addMap['precio'] * addMap['cantidad'];
                  addMap['estado'] = 'comprado';

                  if (!query2.exists) {
                    await Firestore.instance
                        .collection('megacortes')
                        .document('asseburgvera${DateTime.now().year}')
                        .setData({
                      'total': addMap['total'],
                      'año': DateTime.now().year.toString()
                    });
                  } else {
                    await Firestore.instance
                        .runTransaction((transactionHandler) async {
                      DocumentSnapshot freshSnap = await transactionHandler.get(
                          Firestore.instance
                              .collection('megacortes')
                              .document('asseburgvera${DateTime.now().year}'));
                      if (freshSnap.exists) {
                        await transactionHandler.update(freshSnap.reference, {
                          'total': (freshSnap['total'] == null
                                  ? 0
                                  : freshSnap['total']) +
                               addMap['total']
                        });
                      }
                    });
                  }

                  var query = await Firestore.instance
                      .collection('megacortes')
                      .document('asseburgvera${DateTime.now().year}')
                      .collection('cortes')
                      .document('${numberToMonth(DateTime.now().month)}')
                      .get();

                  if (!query.exists) {
                    await Firestore.instance
                        .collection('megacortes')
                        .document('asseburgvera${DateTime.now().year}')
                        .collection('cortes')
                        .document('${numberToMonth(DateTime.now().month)}')
                        .setData({'total': addMap['total']});
                  } else {
                    await Firestore.instance
                        .runTransaction((transactionHandler) async {
                      DocumentSnapshot freshSnap = await transactionHandler.get(
                          Firestore.instance
                              .collection('megacortes')
                              .document('asseburgvera${DateTime.now().year}')
                              .collection('cortes')
                              .document(
                                  '${numberToMonth(DateTime.now().month)}'));
                      if (freshSnap.exists) {
                        await transactionHandler.update(freshSnap.reference, {
                          'total': (freshSnap['total'] == null
                                  ? 0
                                  : freshSnap['total']) +
                               addMap['total']
                        });
                      }
                    });
                  }

                  Firestore.instance
                      .collection('megacortes')
                      .document('asseburgvera${DateTime.now().year}')
                      .collection('cortes')
                      .document('${numberToMonth(DateTime.now().month)}')
                      .collection('productos')
                      .add(addMap);

                  addMap['estado'] = 'faltante';
                  addMap['cantidad'] = cantidad;

                  producto.ref.updateData(addMap);
                }

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String numberToMonth(int number) {
    switch (number) {
      case 1:
        return 'Enero';
        break;
      default:
        return 'Hola';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileTheme(
        iconColor: secondaryColor,
        selectedColor: primaryColor,
        style: ListTileStyle.drawer,
        child: ExpansionTile(
          subtitle: Text('Cantidad: ${producto.cantidad.toString()}'),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                    'Lugar: ${producto.lugar == '' ? 'Sin Lugar' : producto.lugar}'),
                Text('Cantidad: ${producto.cantidad.toString()}'),
                comprado ? Text('Total: \$${producto.total}') : Container(),
                comprado
                    ? Container()
                    : ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => acceptDialog(context),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.check_box,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
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
