// widgets/header_section.dart
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = Scaffold.of(context).appBarMaxHeight ?? 0;
    final height = MediaQuery.of(context).size.height / 2 - appBarHeight;
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Center(
        child: Icon(Icons.image, size: height, color: Colors.blue),
      ),
    );
  }
}
