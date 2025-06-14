import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool isAnimated;
  final bool isGradient;
  final TextType textType;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.ellipsis,
    this.isAnimated = true,
    this.isGradient = false,
    this.textType = TextType.body,
  });

  @override
  State<CustomTextWidget> createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isAnimated) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle _getTextStyle() {
    TextStyle baseStyle;
    
    switch (widget.textType) {
      case TextType.heading:
        baseStyle = const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        );
        break;
      case TextType.subheading:
        baseStyle = const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        );
        break;
      case TextType.body:
        baseStyle = const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.textSecondary,
        );
        break;
      case TextType.caption:
        baseStyle = const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        );
        break;
    }

    return widget.style != null ? baseStyle.merge(widget.style) : baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget;

    if (widget.isGradient && widget.textType == TextType.heading) {
      textWidget = ShaderMask(
        shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: Text(
          widget.text,
          style: _getTextStyle().copyWith(color: Colors.white),
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        ),
      );
    } else {
      textWidget = Text(
        widget.text,
        style: _getTextStyle(),
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
      );
    }

    if (!widget.isAnimated) {
      return textWidget;
    }

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
            child: textWidget,
          ),
        );
      },
    );
  }
}

enum TextType {
  heading,
  subheading,
  body,
  caption,
}