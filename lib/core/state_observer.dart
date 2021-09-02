import 'package:bloc/bloc.dart';
import 'package:weather_app/core/constants/constants.dart';

/// BLoC and Cubit observer.
/// Helps us to track all blocs
/// and cubit events and states,
/// helping to figure out what is hapennig in
/// app.
class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    // Новый БЛоК ивент -> лог

    logger.d(event);

    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    // Новое измненение стейта -> лог

    logger.w(change);

    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // Новая транзиция стейта -> лог

    logger.wtf(transition);

    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    // Новая ошибка -> лог

    logger.e(error);

    super.onError(cubit, error, stackTrace);
  }
}
