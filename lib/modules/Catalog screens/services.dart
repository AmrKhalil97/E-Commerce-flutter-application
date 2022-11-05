import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class services extends StatelessWidget {
  const services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>( // inside the <> you enter the type of your stream
          stream: FirebaseFirestore.instance.collection('categories').where('status',isEqualTo: 'services').snapshots(),
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

            else if (snapshot.hasError) {
              return const Text('Error');
            }
            else {
              return Center(child:  CircularProgressIndicator());
            }
          },
        )
    );
  }
}
