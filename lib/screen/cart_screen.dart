import 'package:flutter/material.dart';
import 'package:whip_smart/auth_methods.dart';
import 'package:whip_smart/model/CartModel.dart';
import 'package:whip_smart/model/CartPostModel.dart';
import 'package:whip_smart/sharedPref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'dart:math';


class CartPage extends StatefulWidget {


  final String value;
  final int count;
  final int rType;
  final String name;
  final String img;
  const CartPage({
    Key? key,
    required this.value, required this.count,required this.name,required this.img,required this.rType,

  }) : super(key: key);



  @override
  _CartPageState createState() => _CartPageState();

}

class _CartPageState extends State<CartPage> {
  //List<int> _quantities = [];
   int len=0,s=0,k=0;
  List todos = [];



  _setupTodo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String stringTodo = prefs.getString('items').toString();
     len = prefs.getInt('len')!;
    List todoList = jsonDecode(stringTodo);
   // print("From DB");
    print(todoList.toString());
    for (var todo in todoList) {
      setState(() {
        todos.add(CartModel().fromJson(todo));
      });
    }
  }


  Future<void> _saveTodo() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('items', jsonEncode(items));
    prefs.setInt('len', len+1);
   // print("Saved");
  }
   Future<void> _addToDB(BuildContext context,List list) async {

     String result = await AuthMethods()
         .cartToDB(list: list);
     print(result);
     if(result.toString()=="success"){
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added to cart Successfully")));
       Navigator.popAndPushNamed(context, "/HomeScreen");
     }

   }
  void _incrementQuantity(int index) {
    setState(() {
      todos[index].count++;
    //  _quantities[index]++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (todos[index].count > 1) {
        todos[index].count--;
      }
    });
  }



  Widget _buildProductCard(int index) {


    return Card(
      shadowColor: Colors.black12,
      color: Colors.black12,
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 30),
      elevation: 20,
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: 100,
            //   height: 100,
            //
            // ),
            Image(image: NetworkImage(todos[index].img),
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${todos[index].doc}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width-220 ,
                        child: Text('${todos[index].name}' , overflow: TextOverflow.ellipsis,)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => {_decrementQuantity(index),},
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${todos[index].count}',
                            style: const TextStyle(fontSize: 18)),

                        IconButton(
                          onPressed: () => {_incrementQuantity(index),},
                          icon: const Icon(Icons.add),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _load() async {
      if(s==0){
        _setupTodo();
        CartModel todo = new CartModel(id: len,doc: widget.value,img: widget.img.toString(),name: widget.name.toString(),count: widget.count,status: false,rType: widget.rType);
        todos.add(todo);
        s++;

      //  _quantities.add(widget.count);
       len = todos.toString().split(",").length;
       print(len);

      }






    }

    if(k==0){

   _load();
   k++;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Your Products',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...List.generate(len, (index) => _buildProductCard(index)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  _saveTodo();
                  Navigator.pushNamed(context, "/ScanScreen");},
                icon: const Icon(Icons.add),
                label: const Text('Add New Product'),

                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {

                  User currentUser = FirebaseAuth.instance.currentUser!;
                  List list=[];
                  for(var ele in todos){
                    CartPost test1 =new CartPost(uid: currentUser.uid , doc: ele.doc, status: ele.rType==1?1:2,count: ele.count, date: DateTime.now(),img: ele.img,name: ele.name,);
                    list.add(test1.toJson());
                  }

                  _addToDB(context,list);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}