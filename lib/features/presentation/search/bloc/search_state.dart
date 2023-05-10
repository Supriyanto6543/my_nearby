part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ResultEntity>? list;
  final int page;
  final AppPermissionEnum enumStatus;
  final String name;

  SearchLoaded._(
      {required this.list,
      this.page = 1,
      this.enumStatus = AppPermissionEnum.nothing,
      this.name = ""});

  SearchLoaded.getList(
      {required List<ResultEntity> list,
      required int page,
      required AppPermissionEnum enumStatus,
      required String name})
      : this._(list: list, page: page, enumStatus: enumStatus, name: name);
}

class SearchError extends SearchState {
  final String message;
  final AppPermissionEnum enumStatus;

  SearchError({required this.message, required this.enumStatus});
}
