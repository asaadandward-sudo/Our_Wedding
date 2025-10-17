import 'package:flutter/material.dart';

class ScrollRevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double beginOpacity;
  final double endOpacity;
  final double beginScale;
  final double endScale;
  final Curve curve;

  const ScrollRevealAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.beginOpacity = 0.0,
    this.endOpacity = 1.0,
    this.beginScale = 0.85,
    this.endScale = 1.0,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollRevealAnimation> createState() => _ScrollRevealAnimationState();
}

class _ScrollRevealAnimationState extends State<ScrollRevealAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  bool _hasAnimated = false;
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _opacityAnimation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: widget.beginScale,
      end: widget.endScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (!_hasAnimated && mounted) {
      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject is RenderBox) {
        final Offset topLeft = renderObject.localToGlobal(Offset.zero);
        final Size size = renderObject.size;
        final double viewportHeight = MediaQuery.of(context).size.height;

        final double itemTop = topLeft.dy;
        final double itemBottom = itemTop + size.height;

        final bool intersectsViewport = itemBottom > 0 && itemTop < viewportHeight * 0.9;
        if (intersectsViewport) {
          _hasAnimated = true;
          _controller.forward();
          _position?.removeListener(_checkVisibility);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      final ScrollableState? scrollable = Scrollable.maybeOf(context);
      final ScrollPosition? pos = scrollable?.position;
      if (_position != pos) {
        _position?.removeListener(_checkVisibility);
        _position = pos;
        _position?.addListener(_checkVisibility);
      }
    });
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            alignment: Alignment.center,
            child: widget.child,
          ),
        );
      },
    );
  }
}
