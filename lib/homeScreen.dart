import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController message = TextEditingController();
  SharedPreferences? prefs;
  String? name ;
  initalize()async{
    prefs = await SharedPreferences.getInstance();
    name = prefs!.getString('name');
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initalize();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Text('User name : $name',style: TextStyle(fontSize: 20),),
          TextField(
            controller: message,
          ),
          ElevatedButton(onPressed: (() async{
            prefs =   await SharedPreferences.getInstance();
            String? name =  prefs!.getString('name');
            print(name);
            FirebaseFirestore.instance.collection(name!).doc("Messages").set({
              "data" : message.text
            });
            }), child: Text('Send to backend'))
        ]),
      ),
    );
  }
}