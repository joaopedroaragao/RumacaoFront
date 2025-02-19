import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:visibility_detector/visibility_detector.dart';

class QuestionsCarousel extends StatefulWidget {
  final int length;
  final ExtendedIndexedWidgetBuilder itemBuilder;
  final Function(int index)? onPageChanged;
  final CarouselOptions? options;
  final int initialPage; // Índice inicial (currentIndex interno será gerenciado)
  final int lastAnsweredIndex; // Índice da última pergunta respondida (-1 se nenhuma foi respondida)
  final VoidCallback? onSwipeForwardBlocked; // Callback quando tentativa de avanço é detectada

  const QuestionsCarousel({
    Key? key,
    required this.length,
    required this.itemBuilder,
    this.onPageChanged,
    this.options,
    required this.initialPage,
    required this.lastAnsweredIndex,
    this.onSwipeForwardBlocked,
  }) : super(key: key);

  @override
  State<QuestionsCarousel> createState() => _QuestionsCarouselState();
}

class _QuestionsCarouselState extends State<QuestionsCarousel> {
  final CarouselSliderController _carouselController = CarouselSliderController();

  int _currentIndex = 0; // Índice atual, gerenciado internamente
  int _startPage = 0; // Índice da página no início do gesto
  int? _pendingPage; // Armazena o índice final enquanto o scroll não terminou
  bool _isScrolling = false; // Indica se o scroll está ativo
  bool _hasTriggeredBounce = false; // Garante que o bounce seja disparado apenas uma vez por gesto
  bool _hasExecutedJump = false; // Garante que o jumpToPage seja chamado apenas uma vez por gesto
  double _scrollOffset = 0;
  ScrollPhysics? _blockingPhysics = const BouncingScrollPhysics();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    // Física base sem bloqueio (movimentos livres).
    const basePhysics = BouncingScrollPhysics();

    // Quando lastAnsweredIndex for -1, o target (página permitida) será 0;
    // caso contrário, será lastAnsweredIndex + 1.
    final int allowedPage = widget.lastAnsweredIndex >= 0
        ? widget.lastAnsweredIndex + 1
        : 0;

    // Se o _scrollOffset indicar que o primeiro item não respondido está visível,
    // então bloqueia o avanço para a direita.
    final effectiveScrollPhysics = (_scrollOffset >= allowedPage)
        ? _blockingPhysics ?? const BlockForwardScrollPhysics(parent: basePhysics, blockForward: true)
        : basePhysics;

    final defaultOptions = CarouselOptions(
      viewportFraction: 0.55,
      initialPage: _currentIndex,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      onScrolled: (value) {
        final newOffset = value ?? 0;
        // Atualiza o _scrollOffset no final do frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _scrollOffset = newOffset;
            });
          }
        });
        // Se o offset indicar que o item permitido está visível, agende a animação.
        if (newOffset >= allowedPage) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _carouselController
                  .animateToPage(allowedPage)
                  .whenComplete(() => Future.delayed(const Duration(milliseconds: 1500), () {
                    setState(() {
                      _blockingPhysics = null;
                    });
                }));
              });
            }
          });
        }
      },
      // Usa a física de scroll efetiva baseada no _scrollOffset.
      scrollPhysics: effectiveScrollPhysics,
      // Garante que o índice final não ultrapasse o permitido.
      onPageChanged: (index, reason) {
        final int target = min(index, allowedPage);
        _pendingPage = target;
        if (mounted) {
          setState(() {
            _currentIndex = target;
          });
        }
      },
    );

    final options = (widget.options ?? defaultOptions).copyWith();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                _startPage = _currentIndex;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isScrolling = true;
                      _hasTriggeredBounce = false;
                      _hasExecutedJump = false;
                    });
                  }
                });
              } else if (notification is ScrollEndNotification) {
                if (_pendingPage != null) {
                  // Limita a navegação a, no máximo, um item por gesto.
                  int diff = _pendingPage! - _startPage;
                  int targetPage = _startPage + diff.sign;
                  targetPage = min(targetPage, allowedPage);
                  widget.onPageChanged?.call(targetPage);
                  _pendingPage = null;
                }
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _isScrolling = false;
                      _hasExecutedJump = false;
                    });
                  }
                });
              }
              if (_currentIndex > widget.lastAnsweredIndex &&
                  notification is OverscrollNotification &&
                  notification.overscroll > 0 &&
                  _startPage == _currentIndex &&
                  !_hasTriggeredBounce) {
                widget.onSwipeForwardBlocked?.call();
                _hasTriggeredBounce = true;
              }
              return false;
            },
            child: AbsorbPointer(
              absorbing: _isScrolling,
              child: CarouselSlider.builder(
                carouselController: _carouselController,
                itemCount: widget.length,
                itemBuilder: (context, index, realIndex) {
                  return widget.itemBuilder(context, index, realIndex);
                },
                options: options,
              ),
            ),
          ),
        );
      },
    );
  }
}

class BlockForwardScrollPhysics extends BouncingScrollPhysics {
  final bool blockForward;

  const BlockForwardScrollPhysics({ScrollPhysics? parent, required this.blockForward})
      : super(parent: parent);

  @override
  BlockForwardScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BlockForwardScrollPhysics(
      parent: buildParent(ancestor),
      blockForward: blockForward,
    );
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Se for um movimento para a direita (value > posição atual)
    // e o bloqueio estiver ativo, impede o movimento.
    if (blockForward && value > position.pixels) {
      return value - position.pixels;
    }
    return super.applyBoundaryConditions(position, value);
  }
}
