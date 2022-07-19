// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'cards_screan.dart';

class cardDetailsScrean extends StatelessWidget {
  const cardDetailsScrean({super.key, required this.userDetails});
  final User userDetails;
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(userDetails.title),
        ),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height/2 ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.network(
                      userDetails.picture,
                      fit: BoxFit.cover,
                      height: 100.0,
                      width: 100.0,
                    ),
                  padding: const EdgeInsets.all(12),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  child: Text(userDetails.content),
                  padding: const EdgeInsets.all(12),
                )
              ],
            ),
          ),
        ));
  }
}
