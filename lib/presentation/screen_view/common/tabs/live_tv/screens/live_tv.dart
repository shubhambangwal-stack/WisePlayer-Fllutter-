import 'package:flutter/material.dart';

class LiveTv extends StatefulWidget {
  const LiveTv({super.key});

  @override
  State<LiveTv> createState() => _LiveTvState();
}

class _LiveTvState extends State<LiveTv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("LiveTv")));
  }
}
