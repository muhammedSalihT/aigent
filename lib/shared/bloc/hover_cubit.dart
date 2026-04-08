import 'package:flutter_bloc/flutter_bloc.dart';

class HoverCubit extends Cubit<bool> {
  HoverCubit() : super(false);

  void onHover(bool isHovered) => emit(isHovered);
}
