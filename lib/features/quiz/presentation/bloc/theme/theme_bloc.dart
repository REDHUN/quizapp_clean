import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_event.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial(false)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeInitial(!state.isDarkMode));
    });
  }
}