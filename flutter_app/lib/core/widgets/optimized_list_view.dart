import 'package:flutter/material.dart';
import 'dart:io';

/// Android-optimized ListView widget
class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Future<void> Function()? onRefresh;
  final bool enablePullToRefresh;

  const OptimizedListView({
    super.key,
    required this.children,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.onRefresh,
    this.enablePullToRefresh = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? _getOptimizedPhysics(),
      children: children,
    );

    // Add pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }

  /// Get optimized physics for Android
  ScrollPhysics _getOptimizedPhysics() {
    if (Platform.isAndroid) {
      return const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      );
    }
    return const AlwaysScrollableScrollPhysics();
  }
}

/// Android-optimized ListView.builder widget
class OptimizedListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Future<void> Function()? onRefresh;
  final bool enablePullToRefresh;
  final double? itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  const OptimizedListViewBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.onRefresh,
    this.enablePullToRefresh = false,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? _getOptimizedPhysics(),
      itemExtent: itemExtent,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );

    // Add pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }

  /// Get optimized physics for Android
  ScrollPhysics _getOptimizedPhysics() {
    if (Platform.isAndroid) {
      return const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      );
    }
    return const AlwaysScrollableScrollPhysics();
  }
}

/// Android-optimized GridView widget
class OptimizedGridView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final SliverGridDelegate gridDelegate;
  final Future<void> Function()? onRefresh;
  final bool enablePullToRefresh;

  const OptimizedGridView({
    super.key,
    required this.children,
    required this.gridDelegate,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.onRefresh,
    this.enablePullToRefresh = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget gridView = GridView(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? _getOptimizedPhysics(),
      gridDelegate: gridDelegate,
      children: children,
    );

    // Add pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      gridView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: gridView,
      );
    }

    return gridView;
  }

  /// Get optimized physics for Android
  ScrollPhysics _getOptimizedPhysics() {
    if (Platform.isAndroid) {
      return const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      );
    }
    return const AlwaysScrollableScrollPhysics();
  }
}

/// Android-optimized GridView.builder widget
class OptimizedGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final SliverGridDelegate gridDelegate;
  final Future<void> Function()? onRefresh;
  final bool enablePullToRefresh;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  const OptimizedGridViewBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.onRefresh,
    this.enablePullToRefresh = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget gridView = GridView.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ?? _getOptimizedPhysics(),
      gridDelegate: gridDelegate,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
    );

    // Add pull-to-refresh if enabled
    if (enablePullToRefresh && onRefresh != null) {
      gridView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: gridView,
      );
    }

    return gridView;
  }

  /// Get optimized physics for Android
  ScrollPhysics _getOptimizedPhysics() {
    if (Platform.isAndroid) {
      return const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      );
    }
    return const AlwaysScrollableScrollPhysics();
  }
}
