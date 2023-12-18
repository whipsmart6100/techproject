
import 'package:flutter/material.dart';
import 'package:whip_smart/fragment/home_fragment.dart';
import 'package:whip_smart/fragment/profile_fragment.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Profile", Icons.person),
    new DrawerItem("Log Out", Icons.exit_to_app)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedDrawerIndex = 0;


  _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popAndPushNamed(context, "/LoginScreen");
  }
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeFragment();
      case 1:
        return new ProfileFragment();
      case 2:
        _logout(context);
        return new HomeFragment();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,

        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(

        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(



              accountName: new Text(""), accountEmail: null,
              decoration: BoxDecoration(color: Colors.brown),),


            new Column(children: drawerOptions,

            )
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}