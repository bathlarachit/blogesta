import 'package:blogesta/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReadPage extends StatelessWidget {
//  const ReadPage({Key? key}) : super(key: key);
//  ReadPage({ this.title, this.img, this.content});
//  final title,img,content;

  @override
  Widget build(BuildContext context) {
    final Map blog = ModalRoute.of(context).settings.arguments;
    final author = blog['author'];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: colour,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
          /*


        */
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: blog['title'],
                child: Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: blog['img'] ??
                          "https://images.unsplash.com/photo-1554188248-986adbb73be4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=750&q=80",
                      maxHeightDiskCache: 200,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.infinity,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('By'),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      '$author',
                      style: TextStyle(
                        color: colour,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Text(
                blog["title"],
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Text(
                blog["content"],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
