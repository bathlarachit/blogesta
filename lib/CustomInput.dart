
import 'package:flutter/material.dart';

import 'constant.dart';

class CustomInput extends StatelessWidget {
  CustomInput({this.labeltext, this.hinttext, this.cont,this.vali});
  final labeltext, hinttext, cont,vali;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: vali,
      controller: cont,
      style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: colour),
      decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
          hintText: hinttext,
          hintStyle: TextStyle(
              color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: colour),
          )),
    );
  }
}
