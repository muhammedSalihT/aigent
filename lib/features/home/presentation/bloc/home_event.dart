import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeScrollChanged extends HomeEvent {
  final double scrollOffset;
  const HomeScrollChanged(this.scrollOffset);
  @override
  List<Object?> get props => [scrollOffset];
}
