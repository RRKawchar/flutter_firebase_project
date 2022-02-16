import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionPageTwo extends StatefulWidget {
  const CollectionPageTwo({Key? key}) : super(key: key);

  @override
  _CollectionPageTwoState createState() => _CollectionPageTwoState();
}

class _CollectionPageTwoState extends State<CollectionPageTwo> {
  final TextEditingController _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final CollectionReference _collectionRef=FirebaseFirestore.instance.collection('users');
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream:_collectionRef.orderBy('name').snapshots() ,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: Text("Something is wrong"),
              );
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return Text('Loading');
            }
            return ListView(
              children: snapshot.data!.docs.map((grocery){
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
        onPressed: (){
          _collectionRef.add({
            "name":_controller.text
          });
          _controller.clear();
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

