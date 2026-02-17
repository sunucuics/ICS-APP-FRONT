/// Cursor-based paginated response model.
/// Backend'in CursorPage<T> response envelope'una karşılık gelir.
///
/// Response format:
/// ```json
/// {
///   "items": [...],
///   "count": 20,
///   "next_cursor": "2024-01-15T10:30:00+00:00",
///   "has_more": true
/// }
/// ```
class CursorPageResponse<T> {
  final List<T> items;
  final int count;
  final String? nextCursor;
  final bool hasMore;

  const CursorPageResponse({
    required this.items,
    required this.count,
    this.nextCursor,
    required this.hasMore,
  });

  factory CursorPageResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsList = json['items'] as List<dynamic>? ?? [];
    return CursorPageResponse(
      items: itemsList
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] as int? ?? 0,
      nextCursor: json['next_cursor'] as String?,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }

  /// Empty response helper
  static CursorPageResponse<T> empty<T>() => CursorPageResponse<T>(
        items: [],
        count: 0,
        nextCursor: null,
        hasMore: false,
      );
}
