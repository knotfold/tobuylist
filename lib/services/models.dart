import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  int cantidad;
  String estado;
  String lugar;
  String nombre;
  int precio;
  int total;
  DocumentReference ref;

  Producto.fromDS(DocumentSnapshot data){
    cantidad = data['cantidad'] ?? 0;
    estado = data['estado'] ?? 'faltante';
    lugar = data['lugarcompra'] ?? 'idk';
    nombre = data['nombre'] ?? 'idk';
    precio = data['precio'] ?? 0;
    total = data['total'] ?? 0;
    ref = data.reference;
    
  }

}