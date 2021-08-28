import 'package:blogesta/blogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'blogList.dart';

class CheckIfPresent extends StatelessWidget {
  final email;

  const CheckIfPresent({Key key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("into Add fucn $email");
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("$email").snapshots(),
        builder: (context, snap) {
          print("running");
          if (snap.hasError) {
            print("inside has error");
            return null;
          }

          if (snap.connectionState == ConnectionState.waiting)
            return null;
          else {
            final list = snap.data.documents;
            print("  -length");
            return (list.isNotEmpty)
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final blog = Blog(
                        author: list[index]['author'],
                        content: list[index]["content"],
                        title: list[index]["title"],
                        url: list[index]["url"],
                      );
                      Check.mp[blog] = true;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: cardList(
                            list[index]["title"],
                            context,
                            list[index]["url"],
                            list[index]["content"],
                            list[index]['author'].toString(),
                            null),
                      );
                    },
                    itemCount: list.length,
                  )
                : null;
          }
        });
  }
}
