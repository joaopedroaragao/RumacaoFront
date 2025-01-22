// widgets/middle_section.dart
import 'package:flutter/material.dart';
import 'description_text.dart';
import 'start_button.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          DescriptionText(),
          SizedBox(height: 20),
          StartButton(),
        ],
      ),
    );
  }
}
