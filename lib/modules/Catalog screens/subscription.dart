import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vlocks/models/categoriesModel.dart';
import 'package:vlocks/models/userModel.dart';
import 'package:vlocks/shared/components/components.dart';
import 'package:vlocks/shared/variables/variables.dart';

class subscription extends StatefulWidget {


  @override
  State<subscription> createState() => _subscriptionState();
}

class _subscriptionState extends State<subscription> {

  @override
  void initState(){
    super.initState();
    getSubscription(storage);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:




StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
  stream: FirebaseFirestore.instance.collection('categories').where('status',isEqualTo: 'subscription').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return
          GridView.builder(
            itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (MediaQuery.of(context).size.height / 1100),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
              return buildCatalogItem(context: context,
                  url: snapshot.data!.docs[index].get('url'),
                  title:  snapshot.data!.docs[index].get('categoryName'),);
              },);
    }
    if (snapshot.hasError) {
      return const Text('Error');
    } else {
      return Center(child: const CircularProgressIndicator());
    }
  },
)
    );


  }


  getSubscription(var storage) async {
    try{
      var results=  await storage.collection('categories').doc('nIE4JSEPRjYwdgbu4kq4').get();
categoriesModel_class.fromJson(results).url;

      print('category status');
      categoryImage=categoriesModel_class.fromJson(results).categoryName;
      print(categoryImage);
      }
          catch(e){
        print(e);
      }
  }

}
