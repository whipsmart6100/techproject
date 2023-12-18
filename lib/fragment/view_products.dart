import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whip_smart/auth_methods.dart';
import 'package:whip_smart/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({Key? key}) : super(key: key);

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {

List todos=[];
int _len=0;

Future<void> _getData() async {
  UserModel userData;
  userData = await AuthMethods().getUserDetails() as UserModel;

  setState(() {
    todos = userData.items;

    _len=todos.length;
   // print(todos[0]["name"].toString());
  });


}

void _returnItem(int index) async {

  User? user =  await  FirebaseAuth.instance.currentUser;

  if(user!=null){
    Future<UserModel> userData = AuthMethods().getUserDetails() as Future<UserModel>;

    List items=[];


    userData.then((value) =>
    //value.uid

    setState(() {

      items = value.items;
    }),

         ).whenComplete(() async => {
    if(items.length !=0){
        print(items),

    items[index]["status"] = DateTime.now(),

    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({"items":items}),
  }
    });




}
}



Widget _buildProductCard(int index) {


  if(todos[index]["name"] != ""){



    return Container(
      child: Card(
        color: Colors.white70,
        child: Column(
          children: [
            //Container(

             // margin: const EdgeInsets.symmetric(vertical: 2),
             // child:
        Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Image(image: NetworkImage(todos[index]["img"]),
                    width: 100,
                    height: 120,
                  ),
                  const SizedBox(width: 10),
              //    Expanded(
                  //  child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id: ${todos[index]["doc"]}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        Container(
                          constraints: BoxConstraints(
                         //   minHeight: 500, //minimum height
  //                        minWidth: 300, // minimum width
//
                           // maxHeight: MediaQuery.of(context).size.height,
                            //maximum height set to 100% of vertical height

                            maxWidth: MediaQuery.of(context).size.width/2,
                            //maximum width set to 100% of width
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width-160,
                            child: Text('Name: ${todos[index]["name"]}',
                              overflow: TextOverflow.ellipsis,style: TextStyle(


                            ),),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text('Quantity Taken: ${todos[index]["count"]}',
                                style: const TextStyle(fontSize: 18)),


                          ],
                        ),
                      //  const SizedBox(width: 10),

                      ],

                    ),
                //  ),


                ],
              ),


          //  ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text('Taken on: ${(todos[index]["date"]).toDate()}',

                      style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold) ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text('${(todos[index]["status"] != 2 ?todos[index]["status"] == 1?"Not Returned":"Returned on ${(todos[index]["status"]).toDate()}":"")}',

                      style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold) ),
                ),

                ElevatedButton(
                    onPressed:()=>{
                      if(todos[index]["status"]==1){
                        _returnItem(index),
                      }
                    else  if(todos[index]["status"]==2){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is Not Returnable"))),

      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item is Already Returned"))),

                      }

                },
                    child: Text(todos[index]["status"]!=2?todos[index]["status"]==1?"Return Item":"Item is Returned":"Item is not Returnable"),
                )
              ],
            )
          ],
        ),

      ),
    );
  }else{
    return   const SizedBox(height: 1);}
}



  @override
  Widget build(BuildContext context) {
  _getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Your Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...List.generate(_len, (index) => _buildProductCard(index)),

              const SizedBox(height: 20),

            ],
          ),
        ),

      ),

    );
  }
}
