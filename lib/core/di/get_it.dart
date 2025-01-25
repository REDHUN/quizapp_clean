import 'package:game_app/core/api/api_client.dart';
import 'package:game_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:game_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:game_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:game_app/features/auth/data/repository/user_repository_impl.dart';
import 'package:game_app/features/auth/domain/repository/auth_repository.dart';
import 'package:game_app/features/auth/domain/repository/user_respository.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/quiz/data/datasource/quiz_datasource.dart';
import 'package:game_app/features/quiz/data/repository_impl/quiz_repository_impl.dart';
import 'package:game_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  registerApiClient();
  registerDataSource();
  registerRepository();

  registerBloc();
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDataSource() {
  var dio = getIt<ApiClient>().getDio();
  var dioWithTokenInterceptor =
      getIt<ApiClient>().getDio(tokenInterceptor: true);
  getIt.registerSingleton(AuthRemoteDataSource(dio: dio));
  getIt.registerSingleton(UserRemoteDataSource(dio: dioWithTokenInterceptor));
  getIt.registerSingleton(QuizDataSource(dio: dioWithTokenInterceptor));
}

void registerRepository() {
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDataSource: getIt()));
  getIt.registerSingleton<QuizRepository>(
      QuizRepositoryImpl(quizDataSource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(
    () => UserBloc(authRepository: getIt(), userRepository: getIt()),
  );
  getIt.registerFactory(
    () => QuizBloc(quizRepository: getIt()),
  );

}
