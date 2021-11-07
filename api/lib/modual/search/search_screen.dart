import 'package:flutter/material.dart';

class SearchsScreen extends StatefulWidget {
  @override
  _SearchsScreenState createState() => _SearchsScreenState();
}

class _SearchsScreenState extends State<SearchsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Searchs'),
      ),
    );
  }
}
