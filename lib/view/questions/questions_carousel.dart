import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuestionsCarousel extends StatefulWidget {
  final int length;
  final ExtendedIndexedWidgetBuilder itemBuilder;
  final Function(VisibilityInfo info, int index)? onVisibilityChanged;
  final CarouselOptions? options;

  const QuestionsCarousel({
    super.key,
    required this.length,
    required this.itemBuilder,
    this.onVisibilityChanged,
    this.options,
  });

  @override
  State<QuestionsCarousel> createState() => _QuestionsCarouselState();
}

class _QuestionsCarouselState extends State<QuestionsCarousel> {
  @override
  Widget build(BuildContext context) {
    return carousel;
  }

  Widget get carousel {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: CarouselSlider.builder(
            itemCount: widget.length,
            itemBuilder: (context, index, realIndex) {
              return VisibilityDetector(
                key: Key("carouselIndex=$index"),
                onVisibilityChanged: (info) => widget.onVisibilityChanged?.call(info, index),
                child: widget.itemBuilder.call(context, index, realIndex),
              );
            },
            options: widget.options ?? CarouselOptions(
              viewportFraction: 0.55, // Mostra os itens ao redor
              initialPage: 0, // O primeiro item que será mostrado
              enlargeCenterPage: true, // Destaca o item central
              enableInfiniteScroll: true, // Permite rolar infinitamente
              scrollPhysics: const BouncingScrollPhysics(), // Dá um efeito de "bounce" ao rolar
            ),
          ),
        );
      },
    );
  }
}
