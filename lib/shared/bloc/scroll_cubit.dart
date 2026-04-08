import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollCubit extends Cubit<bool> {
  ScrollCubit() : super(false);

  void checkScroll(double offset, {double threshold = 50}) {
    final isScrolled = offset > threshold;
    if (state != isScrolled) emit(isScrolled);
  }
}
