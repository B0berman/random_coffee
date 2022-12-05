enum ListStatus { loading, success, failure }

/// {@template list_state}
///
/// {@endtemplate}
class ListState<T> {
  const ListState._({
    this.status = ListStatus.loading,
    this.items = const [],
    this.defaultFilter = ''
  });

  const ListState.empty() : this._();

  const ListState.loading() : this._();

  const ListState.success({required List<T> items, String defaultFilter = ''})
      : this._(status: ListStatus.success, items: items, defaultFilter: defaultFilter);

  const ListState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<T> items;
  final String defaultFilter;

  ListState <T> copyWith({
    ListStatus? status,
    List<T>? items,
    String? defaultFilter,
  }) {
    return ListState._(
      status: status ?? this.status,
      items: items ?? this.items,
      defaultFilter: defaultFilter ?? this.defaultFilter,
    );
  }
}