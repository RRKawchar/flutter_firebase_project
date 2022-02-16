import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<CollectionPage> {


  final textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionRef = FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: Text('data collection'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
          ),
         ElevatedButton.icon(
             onPressed: (){
               setState(() {
                 collectionRef.add({

                   "name":textController.text,

                 });
               });

             },
             icon: Icon(Icons.save),
             label:Text("Save"),
         ),

          StreamBuilder<QuerySnapshot>(
            stream:collectionRef.orderBy("name").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {

                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((grocery) {

                  return ListTile(

                    title: Text(grocery['name']),

                  );
                }).toList(),

              );
            },
          ),
        ],

      ),
    );
  }
}