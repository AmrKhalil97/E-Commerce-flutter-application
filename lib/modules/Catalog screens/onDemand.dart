import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vlocks/models/categoriesModel.dart';
import 'package:vlocks/shared/components/components.dart';

class onDemand extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
        stream: FirebaseFirestore.instance.collection('categories').where('status',isEqualTo: 'onDemand').snapshots(),
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


 

}
getCategories(FirebaseFirestore storage) async{
  try{

    var results=  await storage.collection('categories').where('status',isEqualTo:'onDemand' ).get();

    //doc(uId).get();
    print('result is');
    print(results);
   // print(categoriesModel_class.fromJson(results).url);
  }
  catch(e){
    print(e);
  }
}