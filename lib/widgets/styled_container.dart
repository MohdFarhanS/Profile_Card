import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class StyledContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;
  final bool isAnimated;
  final bool hasHoverEffect;

  const StyledContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = 20,
    this.boxShadow,
    this.border,
    this.isAnimated = true,
    this.hasHoverEffect = false,
  });

  @override
  State<StyledContainer> createState() => _StyledContainerState();
}

class _StyledContainerState extends State<StyledContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isAnimated) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BoxShadow> _getBoxShadow() {
    if (widget.boxShadow != null) {
      return widget.boxShadow!;
    }

    return [
      BoxShadow(
        color: _isHovered
            ? AppColors.primaryColor.withAlpha((255 * 0.7).round())
            : AppColors.shadowColor,
        blurRadius: _isHovered ? 25 : 15,
        offset: const Offset(0, 8),
        spreadRadius: _isHovered ? 2 : 0,
      ),
      BoxShadow(
        color: Colors.white.withAlpha((255 * 0.9).round()),
        blurRadius: 10,
        offset: const Offset(0, -2),
        spreadRadius: 0,
      ),
    ];
  }

  Gradient _getGradient() {
    if (widget.gradient != null) {
      return widget.gradient!;
    }

    return LinearGradient(
      colors: [
        Colors.white,
        Colors.grey.shade50,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  Widget _buildContainer() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? const EdgeInsets.all(20),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundColor == null ? _getGradient() : null,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: _getBoxShadow(),
        border: widget.border ??
            Border.all(
              color: _isHovered
                  ? AppColors.primaryColor.withAlpha((255 * 0.2).round())
                  : Colors.transparent,
              width: 1,
            ),
      ),
      transform: _isHovered
          ? (Matrix4.identity()..scale(1.02))
          : Matrix4.identity(),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget container = _buildContainer();

    if (widget.hasHoverEffect) {
      container = MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: container,
      );
    }

    if (!widget.isAnimated) {
      return container;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: container,
          ),
        );
      },
    );
  }
}