import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/font_family.dart';
import 'package:rumacao_front/view/global/arc_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QuestionSection extends StatefulWidget {
  const QuestionSection({super.key});

  @override
  State<QuestionSection> createState() => _QuestionSectionState();
}

class _QuestionSectionState extends State<QuestionSection> {
  final List<String> items = ['Mascote', 'Produto', 'Serviço', 'Notícia'];
  PageController _pageController = PageController(viewportFraction: 0.4);

  late int red;
  late int green;
  late int blue;
  double value = 0.5;

  late String title = "";
  late String description = "";

  @override
  void initState() {
    super.initState();
    // setValuesFrom(value);
  }

  @override
  Widget build(BuildContext context) {
    return carousel;
  }

  Widget get carousel {
    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (context, index, realIndex) {
        double scale = realIndex == index ? 1.0 : 1.0; // Maior escala para o item central
        double opacity = realIndex == index ? 1.0 : 0.6; // Menor opacidade para os itens ao redor

        return AnimatedBuilder(
          animation: PageController(),
          builder: (context, child) {
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.blue),
                    ),
                    width: 300,
                    height: 300,
                    child: Center(child: Text(items[index])),
                  ),
                ),
              ),
            );
          },
        );
      },
      options: CarouselOptions(
        viewportFraction: 0.6, // Mostra os itens ao redor
        initialPage: 0, // O primeiro item que será mostrado
        enlargeCenterPage: true, // Destaca o item central
        enableInfiniteScroll: true, // Permite rolar infinitamente
        scrollPhysics: BouncingScrollPhysics(), // Dá um efeito de "bounce" ao rolar
      ),
    );
  }
}
