import 'package:flutter/material.dart';
import 'dart:io';

/// Android-optimized animation configurations
class OptimizedAnimations {
  /// Get optimized duration for Android
  static Duration getDuration({
    Duration? customDuration,
    Duration? shortDuration,
    Duration? mediumDuration,
    Duration? longDuration,
  }) {
    if (customDuration != null) return customDuration;
    
    if (Platform.isAndroid) {
      // Android için daha kısa animasyon süreleri
      return shortDuration ?? 
             mediumDuration ?? 
             longDuration ?? 
             const Duration(milliseconds: 200);
    }
    
    return shortDuration ?? 
           mediumDuration ?? 
           longDuration ?? 
           const Duration(milliseconds: 300);
  }

  /// Get optimized curve for Android
  static Curve getCurve({Curve? customCurve}) {
    if (customCurve != null) return customCurve;
    
    if (Platform.isAndroid) {
      // Android için daha smooth curve
      return Curves.easeOutCubic;
    }
    
    return Curves.easeInOut;
  }

  /// Get optimized animation controller for Android
  static AnimationController createController(
    TickerProvider vsync, {
    Duration? duration,
    Duration? reverseDuration,
  }) {
    return AnimationController(
      duration: getDuration(customDuration: duration),
      reverseDuration: getDuration(customDuration: reverseDuration),
      vsync: vsync,
    );
  }
}

/// Android-optimized fade transition
class OptimizedFadeTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Duration? duration;
  final Curve? curve;

  const OptimizedFadeTransition({
    super.key,
    required this.child,
    required this.animation,
    this.duration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: OptimizedAnimations.getCurve(customCurve: curve),
      ),
      child: child,
    );
  }
}

/// Android-optimized scale transition
class OptimizedScaleTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final Duration? duration;
  final Curve? curve;
  final Alignment alignment;

  const OptimizedScaleTransition({
    super.key,
    required this.child,
    required this.animation,
    this.duration,
    this.curve,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: OptimizedAnimations.getCurve(customCurve: curve),
      ),
      alignment: alignment,
      child: child,
    );
  }
}

/// Android-optimized slide transition
class OptimizedSlideTransition extends StatelessWidget {
  final Widget child;
  final Animation<Offset> animation;
  final Duration? duration;
  final Curve? curve;

  const OptimizedSlideTransition({
    super.key,
    required this.child,
    required this.animation,
    this.duration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: child,
    );
  }
}

/// Android-optimized animated container
class OptimizedAnimatedContainer extends StatelessWidget {
  final Widget child;
  final Duration? duration;
  final Curve? curve;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Decoration? decoration;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;

  const OptimizedAnimatedContainer({
    super.key,
    required this.child,
    this.duration,
    this.curve,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.constraints,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: OptimizedAnimations.getDuration(customDuration: duration),
      curve: OptimizedAnimations.getCurve(customCurve: curve),
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      constraints: constraints,
      alignment: alignment,
      child: child,
    );
  }
}

/// Android-optimized animated opacity
class OptimizedAnimatedOpacity extends StatelessWidget {
  final Widget child;
  final double opacity;
  final Duration? duration;
  final Curve? curve;

  const OptimizedAnimatedOpacity({
    super.key,
    required this.child,
    required this.opacity,
    this.duration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: OptimizedAnimations.getDuration(customDuration: duration),
      curve: OptimizedAnimations.getCurve(customCurve: curve),
      child: child,
    );
  }
}

/// Android-optimized page transition
class OptimizedPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Duration? duration;
  final Curve? curve;
  OptimizedPageRoute({
    required this.child,
    this.duration,
    this.curve,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionDuration: OptimizedAnimations.getDuration(
            customDuration: duration,
          ),
          transitionsBuilder: _defaultTransitionsBuilder,
        );

  static Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (Platform.isAndroid) {
      // Android için optimize edilmiş geçiş
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }

    // iOS için standart geçiş
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
