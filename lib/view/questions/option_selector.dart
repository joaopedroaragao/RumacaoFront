import 'package:flutter/material.dart';
import 'package:rumacao_front/constants/font_family.dart';

/// Representa o aspecto visual de uma opção.
class OptionButton {
  final Color borderColor;
  final Color backgroundColor;
  final Color selectedColor;
  final double size;
  final double borderWidth;
  final String label;
  final TextStyle? textStyle;

  OptionButton({
    required this.borderColor,
    required this.backgroundColor,
    required this.selectedColor,
    this.label = "",
    this.size = 40.0,
    this.borderWidth = 2.0,
    this.textStyle,
  });
}

/// Tween customizado que utiliza um TweenSequence internamente.
class JumpTween extends Tween<double> {
  final TweenSequence<double> sequence;

  JumpTween({
    required double begin,
    required double end,
    required this.sequence,
  }) : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    return sequence.transform(t);
  }
}

/// Widget que exibe as opções com a animação de "pulo" ao selecionar.
class OptionSelector extends StatefulWidget {
  final List<OptionButton> options;
  final int? selectedIndex;
  final void Function(int)? onSelected;
  final double spacing;

  const OptionSelector({
    Key? key,
    required this.options,
    this.selectedIndex,
    this.onSelected,
    this.spacing = 8.0,
  }) : super(key: key);

  @override
  State<OptionSelector> createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {
  int? _animatedIndex; // Índice da opção que deve animar

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.options.length, (index) {
        final option = widget.options[index];
        final isSelected = index == widget.selectedIndex;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onSelected?.call(index);
                  // Inicia a animação para a opção tocada.
                  setState(() {
                    _animatedIndex = index;
                  });
                  // Após a duração da animação, reseta o índice animado.
                  Future.delayed(const Duration(milliseconds: 300), () {
                    setState(() {
                      _animatedIndex = null;
                    });
                  });
                },
                child: TweenAnimationBuilder<double>(
                  tween: _animatedIndex == index
                      ? JumpTween(
                    begin: 0,
                    end: 0,
                    sequence: TweenSequence<double>([
                      TweenSequenceItem(
                        tween: Tween(begin: 0.0, end: -10.0)
                            .chain(CurveTween(curve: Curves.easeOut)),
                        weight: 50,
                      ),
                      TweenSequenceItem(
                        tween: Tween(begin: -10.0, end: 0.0)
                            .chain(CurveTween(curve: Curves.easeIn)),
                        weight: 50,
                      ),
                    ]),
                  )
                      : Tween<double>(begin: 0, end: 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, value),
                      child: child,
                    );
                  },
                  child: Container(
                    width: option.size,
                    height: option.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: option.backgroundColor,
                      border: Border.all(
                        color: option.borderColor,
                        width: option.borderWidth,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                      child: Container(
                        width: option.size * 0.5,
                        height: option.size * 0.5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: option.selectedColor,
                        ),
                      ),
                    )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                option.label,
                style: option.textStyle ??
                    TextStyle(
                      fontFamily: FontFamily.inter.name,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
