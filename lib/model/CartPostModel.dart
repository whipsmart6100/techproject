import 'package:cloud_firestore/cloud_firestore.dart';

class CartPost{
  final String uid;
  final String doc;
  final String name;
  final String img;

  final int count;
  final int status;

  final DateTime date;

  CartPost(
      {
        required this.uid,
        required this.doc,
        required this.name,

        required this.img,
        required this.count,
        required this.status,
        required this.date});

  Map<String, dynamic> toJson() => {

    "uid": uid,
    "doc": doc,
    "count": count,
    "img": img,
   // "rType": rType,
    "name": name,
    "status": status,
    "date": date,
  };

  static CartPost? fromSnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CartPost(
      uid: snapshot['uid'],
      doc: snapshot['doc'],
      name: snapshot['name'],
    //  rType: snapshot['rType'],
      img: snapshot['img'],
      count: snapshot['count'],
      status: snapshot['status'],
      date: snapshot['date'],

    );
  }
}