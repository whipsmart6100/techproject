import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whip_smart/model/CartModel.dart';
import 'package:whip_smart/model/CartPostModel.dart';

import '../model/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
    await _firestore.collection('users').doc(currentUser.uid).get();
    return UserModel.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String? name,
    required String? email,
    required String? password,
    required String? username,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);
        print(user.user!.uid);

        CartPost post= CartPost(uid: "", doc: "", count: 0, status: 0,date: DateTime.now(),name: "",img: "");
        List list2=[];
        list2.add(post.toJson());
        UserModel userModel = UserModel(
          email: email,
          name: name!,
          uid: user.user!.uid,
          username: username!,
          items: list2,
          following: [],
        );

        await _firestore.collection('users').doc(user.user!.uid).set(
          userModel.toJson(),
        );
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }


  Future<String> cartToDB({
    required List list,
    //required int? count,
    //required DateTime? date,
  }) async {
    String result = "";
    int do1=0;
    List past = [];



    UserModel userData;
    userData = await AuthMethods().getUserDetails() as UserModel;


    if(userData!=null){

      past = userData.items;




   // if(do1==1){

      for(var item in list) {
        past.add(item);
    }
   // }
     result = 'Some error occurred';
    String uid;
    User currentUser = _auth.currentUser!;
    uid = currentUser.uid;
    try {
      if (list != null && uid != null  ) {
        // UserCredential user = await _auth.createUserWithEmailAndPassword(
        //     email: email, password: password!);
        // print(user.user!.uid);



        // UserModel userModel1 = UserModel(
        //   email: currentUser.email.toString(),
        //   name: "",
        //   uid: uid,
        //   username:"",
        //   followers: userModel,
        //   following: [],
        // );

       // past.add(item);
        await _firestore.collection('users').doc(uid).update(
          {'items':past},
        );
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }

    }
  //  }
    return result;

}
}


