import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionAuth extends StatefulWidget {
  const CollectionAuth({Key? key}) : super(key: key);

  @override
  _CollectionAuthState createState() => _CollectionAuthState();
}

class _CollectionAuthState extends State<CollectionAuth> {

  final TextEditingController _textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CollectionReference fruits = FirebaseFirestore.instance.collection('fruits');
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: fruits.orderBy('name').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Text('Loading'),
              );

            }
            return ListView(
              children: snapshot.data!.docs.map((grocery) {
                return Center(
                  child: ListTile(
                    title: Text(grocery['name']),
                    trailing: IconButton(
                      onPressed: (){
                        grocery.reference.delete();
                      },
                      icon: Icon(Icons.delete),
                    ),

                  ),
                );

              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){
          fruits.add({

            "name":_textController.text,

          });
          _textController.clear();
        },
      ),
    );
  }
}
