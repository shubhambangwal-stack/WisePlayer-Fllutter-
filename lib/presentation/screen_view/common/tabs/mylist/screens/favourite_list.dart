import 'package:flutter/material.dart';

class FavouriteList extends StatefulWidget {
  const FavouriteList({super.key});

  @override
  State<FavouriteList> createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("FavouriteList")));
  }
}
