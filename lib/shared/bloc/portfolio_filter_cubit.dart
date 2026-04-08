import 'package:flutter_bloc/flutter_bloc.dart';

class PortfolioFilterCubit extends Cubit<String> {
  PortfolioFilterCubit() : super('All');

  void setFilter(String filter) => emit(filter);
}
