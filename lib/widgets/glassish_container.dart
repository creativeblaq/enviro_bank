import 'dart:ui';

import 'package:flutter/material.dart';

class GlassishContainer extends StatelessWidget {
  const GlassishContainer(
      {Key? key,
      required this.child,
      this.margin,
      this.borderRadius,
      this.border,
      this.color,
      this.imageFilter,
      this.height,
      this.width,
      this.constraints})
      : super(key: key);
  final Widget child;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Color? color;
  final ImageFilter? imageFilter;
  final double? height;
  final double? width;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        margin: margin ??
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        constraints: constraints,
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF403648).withOpacity(0.7),
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          border: border,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          child: BackdropFilter(
            filter: imageFilter ??
                ImageFilter.blur(
                    sigmaX: 3.3, sigmaY: 3.3, tileMode: TileMode.clamp),
            child: child,
          ),
        ));
  }
}
