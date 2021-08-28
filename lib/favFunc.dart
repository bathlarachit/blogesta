import 'package:blogesta/blogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String disp = "";
Future<void> insertData(final blog) async {
  Firestore firestore = Firestore.instance;

  firestore.collection("$disp").add(blog).catchError((e) {
    print(e);
  });
}

Future<void> addFav(title, url, content, author) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final user = await _auth.currentUser();
  final dis = user.email;
  disp = dis;
  final blog = Blog(author: author, content: content, title: title, url: url);
  insertData(blog.toMap());
}

class ListFav {
  static List list = [];

  
  

}
