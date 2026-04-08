import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  final bool isScrolled;
  const HomeState({required this.isScrolled});
  @override
  List<Object?> get props => [isScrolled];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(isScrolled: false);
}

class HomeScrolled extends HomeState {
  const HomeScrolled({required super.isScrolled});
}
