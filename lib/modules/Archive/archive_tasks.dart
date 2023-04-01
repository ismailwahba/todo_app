// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore

import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // ignore: prefer_const_constructors
        child: Center(
      child: Text("Archive"),
    ));
  }
}
