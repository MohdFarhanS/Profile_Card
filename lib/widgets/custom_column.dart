import 'package:flutter/material.dart';

class CustomColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final bool addAnimations;

  const CustomColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding,
    this.addAnimations = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget columnWidget = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: addAnimations ? _buildAnimatedChildren() : children,
    );

    if (padding != null) {
      columnWidget = Padding(
        padding: padding!,
        child: columnWidget,
      );
    }

    return columnWidget;
  }

  List<Widget> _buildAnimatedChildren() {
    return children.asMap().entries.map((entry) {
      int index = entry.key;
      Widget child = entry.value;
      
      return TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 500 + (index * 100)),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: child,
      );
    }).toList();
  }
}