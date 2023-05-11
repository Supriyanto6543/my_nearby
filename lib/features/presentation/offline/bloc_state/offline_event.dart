part of 'offline_bloc.dart';

@immutable
abstract class OfflineBlocEvent extends Equatable {
  const OfflineBlocEvent();
  @override
  List<Object> get props => [];
}

class OfflineEventList extends OfflineBlocEvent {}
