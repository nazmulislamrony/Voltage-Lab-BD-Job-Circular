import 'package:flutter/material.dart';
class items_list extends StatefulWidget {

String? url;
  @override
  State<items_list> createState() => _items_listState();

  items_list({this.url});
}

class _items_listState extends State<items_list> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${widget.url}"),
      ),
    );
  }
}
