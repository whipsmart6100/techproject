import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whip_smart/model/CartPostModel.dart';

class UserModel{
  final String email;
  final String name;
  final String uid;
  final String username;
  final List items;
  final List following;

  UserModel(
      {required this.email,
        required this.name,
        required this.username,
        required this.uid,
        required this.items,
        required this.following});

  Map<String, dynamic> toJson() => {
    "email": email,
    "uid": uid,
    "name": name,
    "username": username,
    "items": items,
    "following": following,
  };

  static UserModel? fromSnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      name: snapshot['name'],
      following: snapshot['following'],
      items: snapshot['items'],
      email: snapshot['email'],
    );
  }
}