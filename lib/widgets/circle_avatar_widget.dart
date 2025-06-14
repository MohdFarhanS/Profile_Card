import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CircleAvatarWidget extends StatefulWidget {
  final String imageUrl;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final bool isAnimated;

  const CircleAvatarWidget({
    super.key,
    required this.imageUrl,
    this.radius = 50,
    this.showBorder = true,
    this.borderColor = AppColors.primaryColor,
    this.borderWidth = 3,
    this.isAnimated = true,
  });

  @override
  State<CircleAvatarWidget> createState() => _CircleAvatarWidgetState();
}

class _CircleAvatarWidgetState extends State<CircleAvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isAnimated) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;
    if (widget.imageUrl.isNotEmpty) {
      if (widget.imageUrl.startsWith('http://') || widget.imageUrl.startsWith('https://')) {
        imageProvider = NetworkImage(widget.imageUrl);
      } else {
        imageProvider = AssetImage(widget.imageUrl);
      }
    }

    Widget avatarWidget = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 5,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(widget.borderWidth),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CircleAvatar(
          radius: widget.radius - widget.borderWidth,
          backgroundColor: AppColors.backgroundColor,
          backgroundImage: imageProvider,
          child: widget.imageUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: widget.radius,
                  color: AppColors.textSecondary,
                )
              : null,
        ),
      ),
    );

    if (!widget.isAnimated) {
      return avatarWidget;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 0.1,
            child: avatarWidget,
          ),
        );
      },
    );
  }
}