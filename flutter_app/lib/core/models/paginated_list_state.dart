/// State model for paginated (infinite scroll) lists.
/// StateNotifier ile kullanılır — FutureProvider yerine.
class PaginatedListState<T> {
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? nextCursor;
  final String? error;

  const PaginatedListState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.nextCursor,
    this.error,
  });

  /// Initial loading state
  factory PaginatedListState.loading() => const PaginatedListState(
        isLoading: true,
      );

  /// Error state
  factory PaginatedListState.error(String message) => PaginatedListState(
        error: message,
      );

  PaginatedListState<T> copyWith({
    List<T>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? nextCursor,
    String? error,
  }) {
    return PaginatedListState<T>(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      nextCursor: nextCursor ?? this.nextCursor,
      error: error,
    );
  }

  /// Has data and no error
  bool get hasData => items.isNotEmpty && error == null;

  /// Is empty and not loading
  bool get isEmpty => items.isEmpty && !isLoading && error == null;
}
