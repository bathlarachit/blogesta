import 'package:blogesta/constant.dart';
import 'package:blogesta/write.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'blogList.dart';

class DrawerWig extends StatelessWidget {
  // const DrawerWig({Key key}) : super(key: key);

  final display, email;

  const DrawerWig({Key key, this.display, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: ListView(
            children: [
              header(display,email),
              Divider(
                height: 60,
              ),
              drawerItem(CupertinoIcons.pencil, "Write a blog", () {
                // Route route =
                //     MaterialPageRoute(builder: (context) => WriteBlog());
                // Navigator.pushReplacement(context, route);
                //Navigator.pushNamed(context, '/write');
              }, context),
              drawerItem(Icons.menu_book_outlined, "Explore blogs", () {
                // Route route =
                //     MaterialPageRoute(builder: (context) => BlogList());
                // Navigator.pushReplacement(context, route);
              }, context),
              drawerItem(Icons.favorite, "Favorite blogs", () {}, context),
              Divider(height: 50),
              DrawItem(
                func: null,
                icon: Icons.logout,
                text: "Sign Out",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawItem extends StatelessWidget {
  final func, icon, text;

  const DrawItem({Key key, this.func, this.icon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: colour,
        ),
        title: Text(text),
      ),
    );
  }
}

Widget header(final name,final email) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/boy.jpg'),
          // child: Image(
          //   image: AssetImage('assets/images/boy.jpg'),
          // ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$email',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget drawerItem(icon, text, func, context) {
  return InkWell(
    onTap: func,
    child: ListTile(
      leading: Icon(
        icon,
        color: colour,
      ),
      title: Text(text),
    ),
  );
}
