import 'package:blogesta/blogModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'CustomInput.dart';
import 'constant.dart';

String def =
    "https://images.unsplash.com/photo-1554188248-986adbb73be4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80";

class WriteBlog extends StatefulWidget {
  //WriteBlog({Key key}) : super(key: key);
  @override
  _WriteBlogState createState() => _WriteBlogState();
}

class _WriteBlogState extends State<WriteBlog> {
  bool isSpin = false;
  String len(val) {
    return val.length > 6
        ? null
        : "This Field can be not empty ";
  }

  final _titleController = TextEditingController();

  final _urlController = TextEditingController();

  final _contentController = TextEditingController();

  Future<void> insertData(final blog) async {
    Firestore firestore = Firestore.instance;
    firestore.collection("blog").add(blog).catchError((e) {
      print(e);
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: colour,
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: isSpin,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
              key: formKey,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Image(
                    image: AssetImage('assets/images/out_of_box.png'),
                  ),
                  CustomInput(
                    cont: _titleController,
                    labeltext: "Title of your blog",
                    hinttext: "Enter Your Title ",
                    vali: len,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomInput(
                    vali: null,
                    cont: _urlController,
                    hinttext: "Paste url link,leave empty for default image",
                    labeltext: "Image URL",
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    validator: len,
                    controller: _contentController,
                    minLines: 1,
                    maxLines: 1000,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        labelText: "Write your content here",
                        hintText: "Press Enter for new line",
                        labelStyle:
                            TextStyle(color: Colors.grey[700], fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: colour),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.white,
                    highlightColor: colour,
                    //TODO: ON Tap
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        try {
                          setState(() {
                            isSpin = true;
                          });

                          final title = _titleController.text;

                          final url = (_urlController.text.isEmpty)
                              ? def
                              : _urlController.text;

                          final content = _contentController.text;
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          final user = await _auth.currentUser();
                          final blog = Blog(
                              content: content,
                              title: title,
                              url: url,
                              author: user.displayName);

                          insertData(blog.toMap());
                          final snackBar =
                              SnackBar(content: Text('Blog Posted'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _contentController.clear();
                          _titleController.clear();
                          _urlController.clear();
                            setState(() {
                            isSpin = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'POST',
                          style: TextStyle(
                            letterSpacing: 0.4,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: colour,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
