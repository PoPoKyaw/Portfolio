import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double hoverScale;
  final Duration duration;
  final BorderRadius? borderRadius;
  final Color? hoverBorderColor;
  final Color? hoverGlowColor;

  const HoverCard({
    super.key,
    required this.child,
    this.onTap,
    this.hoverScale = 1.025,
    this.duration = const Duration(milliseconds: 200),
    this.borderRadius,
    this.hoverBorderColor,
    this.hoverGlowColor,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = widget.borderRadius ?? BorderRadius.circular(16);
    final scale = _isHovered ? widget.hoverScale : 1.0;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeOutCubic,
          transform: Matrix4.diagonal3Values(scale, scale, 1.0),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: effectiveRadius,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.hoverGlowColor ?? const Color(0x3300F2FE),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [
                    const BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
