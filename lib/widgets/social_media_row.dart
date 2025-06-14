import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';

class SocialMediaRow extends StatefulWidget {
  final List<SocialMedia> socialMediaList;
  final bool isAnimated;
  final double iconSize;
  final MainAxisAlignment alignment;

  const SocialMediaRow({
    super.key,
    required this.socialMediaList,
    this.isAnimated = true,
    this.iconSize = 24,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  State<SocialMediaRow> createState() => _SocialMediaRowState();
}

class _SocialMediaRowState extends State<SocialMediaRow>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _rotationAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = [];
    _scaleAnimations = [];
    _rotationAnimations = [];

    for (int i = 0; i < widget.socialMediaList.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );

      final scaleAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

      final rotationAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

      _controllers.add(controller);
      _scaleAnimations.add(scaleAnimation);
      _rotationAnimations.add(rotationAnimation);

      if (widget.isAnimated) {
        Future.delayed(Duration(milliseconds: 800 + (i * 100)), () {
          if (mounted) controller.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: widget.alignment,
      children:
          widget.socialMediaList.asMap().entries.map((entry) {
            int index = entry.key;
            SocialMedia socialMedia = entry.value;

            Widget iconWidget = _SocialMediaIcon(
              socialMedia: socialMedia,
              iconSize: widget.iconSize,
            );

            if (!widget.isAnimated) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: iconWidget,
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AnimatedBuilder(
                animation: _controllers[index],
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimations[index].value,
                    child: Transform.rotate(
                      angle: _rotationAnimations[index].value * 0.1,
                      child: iconWidget,
                    ),
                  );
                },
              ),
            );
          }).toList(),
    );
  }
}

class _SocialMediaIcon extends StatefulWidget {
  final SocialMedia socialMedia;
  final double iconSize;

  const _SocialMediaIcon({required this.socialMedia, required this.iconSize});

  @override
  State<_SocialMediaIcon> createState() => _SocialMediaIconState();
}

class _SocialMediaIconState extends State<_SocialMediaIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _hoverAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget iconContent;

    if (widget.socialMedia.iconPath != null &&
        widget.socialMedia.iconPath!.isNotEmpty) {
      iconContent = Image.asset(
        widget.socialMedia.iconPath!,
        width: widget.iconSize,
        height: widget.iconSize,
        color: _isHovered ? Colors.white : null,
      );
    } else if (widget.socialMedia.iconData != null) {
      iconContent = Icon(
        widget.socialMedia.iconData,
        size: widget.iconSize,
        color: _isHovered ? Colors.white : widget.socialMedia.color,
      );
    } else {
      iconContent = Icon(Icons.error, size: widget.iconSize, color: Colors.red);
    }
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _hoverController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: GestureDetector(
        onTap: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${widget.socialMedia.platform}...'),
              duration: const Duration(seconds: 1),
              backgroundColor: widget.socialMedia.color,
            ),
          );
          
        },
        child: AnimatedBuilder(
          animation: _hoverAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _hoverAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient:
                      _isHovered
                          ? LinearGradient(
                            colors: [
                              widget.socialMedia.color.withAlpha(
                                (255 * 0.8).round(),
                              ),
                              widget.socialMedia.color,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : LinearGradient(
                            colors: [Colors.white, Colors.grey.shade50],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color:
                          _isHovered
                              ? widget.socialMedia.color.withAlpha(
                                (255 * 0.3).round(),
                              )
                              : AppColors.shadowColor,
                      blurRadius: _isHovered ? 15 : 8,
                      offset: const Offset(0, 4),
                      spreadRadius: _isHovered ? 2 : 0,
                    ),
                  ],
                ),
                child: iconContent,
              ),
            );
          },
        ),
      ),
    );
  }
}