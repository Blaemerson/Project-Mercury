import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectmercury/models/store_item.dart';
import 'package:projectmercury/resources/firestore_methods.dart';
import 'package:projectmercury/resources/locator.dart';

import '../widgets/store_item_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirestoreMethods _firestore = locator.get<FirestoreMethods>();

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Furniture Store',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Flexible(
        //   child: ListView.builder(
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        //         child: FittedBox(
        //           child: Column(
        //             children: [
        //               Container(
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                       color: Theme.of(context).colorScheme.primaryContainer,
        //                     ),
        //                   child: IconButton(
        //                     onPressed: () {},
        //                     icon: const Icon(Icons.bed),
        //                   )),
        //                   Text(itemType.values[index].name + 's'),
        //             ],
        //           ),
        //         ),
        //       );
        //     },
        //     itemCount: itemType.values.length,
        //     scrollDirection: Axis.horizontal,
        //   ),
        // ),
        SizedBox(
          height: 300,
          child: StreamBuilder(
              stream: _firestore.store.stream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading store.'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return StoreItemCard(
                      storeItem: StoreItem.fromSnap(snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  scrollDirection: Axis.horizontal,
                );
              }),
        ),
      ],
    );
  }
}
