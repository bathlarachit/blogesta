import 'package:blogesta/blogModel.dart';
import 'package:blogesta/favFunc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BlogList extends StatelessWidget {
  //const BlogList({ Key? key }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    final Map em = ModalRoute.of(context).settings.arguments;
    final _email = em['email'];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final snackBar = SnackBar(
                  content: Text('Add items to favorite by double tap on it'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: Icon(
              Icons.help_outline_outlined,
              color: colour,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
          color: colour,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "Explore your Interest",
          style: TextStyle(
              color: colour, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 12),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("blog").snapshots(),
          builder: (context, snap) {
            if (snap.hasError)
              return Text(
                "Some thing went wrong",
                style: TextStyle(fontSize: 22),
              );
            if (snap.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else {
              final list = snap.data.documents;

              // final _favList = favsnap.
              // final wib = CheckIfPresent(
              //   email: _email,
              // ).build(context);
                 
              return (list.isNotEmpty)
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final blog = Blog(
                          author: list[index]['author'],
                          content: list[index]["content"],
                          title: list[index]["title"],
                          url: list[index]["url"],
                        );
                        var v = Check.mp[blog];
                        print(v);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: cardList(
                              list[index]["title"],
                              context,
                              list[index]["url"],
                              list[index]["content"],
                              list[index]['author'].toString(),
                              v),
                        );
                      },
                      itemCount: list.length,
                    )
                  : Center(child: Text("No to show here"));
            }
          },
        ),
      ),
    );
  }
}

Widget cardList(txt, context, img, content, author, v) {
  return SizedBox(
    height: 120,
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/read',
          arguments: {
            "img": img,
            "content": content,
            "title": txt,
            "author":author
          },
        );
      },
      onDoubleTap: () async {
        print('started');
        await addFav(txt, img, content, author);
        print('done');
      },
      child: Row(
        children: [
          Hero(
            tag: txt,
            child: Container(
              height: 120,
              width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: img,
                  maxWidthDiskCache: 160,
                  fit: BoxFit.fill,
                ),
              ),
              decoration: BoxDecoration(
                // image: DecorationImage(
                //     image: CachedNetworkImageProvider(

                //         "https://images.unsplash.com/photo-1568992687947-868a62a9f521?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1789&q=80"),
                //     fit: BoxFit.fill),
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text('05 Mins Read', style: cardMIn),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    txt,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('By - $author'),
                            Icon(
                              v == null
                                  ? Icons.favorite_border_outlined
                                  : Icons.favorite,
                              color: Colors.red,
                              size: 25,
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class Check {
  static Map<Blog, bool> mp = {};
}
