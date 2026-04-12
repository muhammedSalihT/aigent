import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<HomeScrollChanged>(_onScrollChanged);
  }

  void _onScrollChanged(HomeScrollChanged event, Emitter<HomeState> emit) {
    final scrolled = event.scrollOffset > 50;
    if (scrolled != state.isScrolled) {
      emit(HomeScrolled(isScrolled: scrolled));
    }
  }
}
