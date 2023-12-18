import 'dart:convert';

class CartModel {
  int? id;
  String? doc;
  String? name;
  String? img;
  int? count;
  bool? status;
  int? rType;


  CartModel({this.id, this.doc,this.name,this.img, this.count, this.status, this.rType}) {
    id = this.id;
    doc = this.doc;
    name = this.name;
    img = this.img;
    rType = this.rType;

    count = this.count;
    status = this.status;
  }

  toJson() {
    return {
      "id": id,
      "doc": doc,
      "rType": rType,
      "name": name,
      "img": img,
      "count": count,
      "status": status
    };
  }

  fromJson(jsonData) {
    return CartModel(
        id: jsonData['id'],
        doc: jsonData['doc'],
        name: jsonData['name'],
        img : jsonData['img'],
        count: jsonData['count'],
        rType: jsonData['rType'],
        status: jsonData['status']);
  }
}