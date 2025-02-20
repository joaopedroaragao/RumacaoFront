import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rumacao_front/constants/app_constants.dart';

class BaseInteractionScreenHeader extends StatefulWidget {
  final String text;

  const BaseInteractionScreenHeader({super.key, required this.text});

  @override
  State<BaseInteractionScreenHeader> createState() =>
      _BaseInteractionScreenHeaderState();
}

class _BaseInteractionScreenHeaderState
    extends State<BaseInteractionScreenHeader> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Força o rebuild da UI quando as dimensões da janela mudarem.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            Expanded(
              flex: 4,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: AppStyles.headerText, // Usando estilo centralizado no AppStyles
              ),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}
