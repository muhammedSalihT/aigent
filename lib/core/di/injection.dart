import 'package:get_it/get_it.dart';
import '../../features/contact/presentation/bloc/contact_bloc.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // BLoC
  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerFactory<ContactBloc>(() => ContactBloc());
}
