import 'package:game_app/core/api/api_client.dart';
import 'package:game_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:game_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:game_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:game_app/features/auth/data/repository/user_repository_impl.dart';
import 'package:game_app/features/auth/domain/repository/auth_repository.dart';
import 'package:game_app/features/auth/domain/repository/user_respository.dart';
import 'package:game_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:game_app/features/create_quiz/data/datasource/create_quiz_datasource.dart';
import 'package:game_app/features/create_quiz/data/repository_impl/create_quiz_repository_impl.dart';
import 'package:game_app/features/create_quiz/domain/repository/quiz_create_repository.dart';
import 'package:game_app/features/create_quiz/presentation/bloc/create_quiz_bloc.dart';
import 'package:game_app/features/question_manegement/data/datasource/question_manage_datasource.dart';
import 'package:game_app/features/question_manegement/data/repository_impl/question_manage_repository_impl.dart';
import 'package:game_app/features/question_manegement/domain/repository/question_manage_repository.dart';
import 'package:game_app/features/question_manegement/presentation/bloc/question_manage/question_manage_bloc.dart';
import 'package:game_app/features/quiz/data/datasource/quiz_datasource.dart';
import 'package:game_app/features/quiz/data/repository_impl/quiz_repository_impl.dart';
import 'package:game_app/features/quiz/domain/repository/quiz_repository.dart';
import 'package:game_app/features/quiz/presentation/bloc/quiz/quiz_bloc.dart';
import 'package:game_app/features/quiz/presentation/bloc/theme/theme_bloc.dart';
import 'package:game_app/features/quiz_report/data/datasource/quiz_report_datasource.dart';
import 'package:game_app/features/quiz_report/data/repository_impl/quiz_report_repository_impl.dart';
import 'package:game_app/features/quiz_report/domain/repository/quiz_report_repository.dart';
import 'package:game_app/features/quiz_report/presentation/bloc/quiz_report_bloc.dart';
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
  getIt.registerSingleton(QuizReportDataSource(dio: dioWithTokenInterceptor));
  getIt.registerSingleton(CreateQuizDataSource(dio: dioWithTokenInterceptor));
  getIt.registerSingleton(
      QuestionManageDatasource(dio: dioWithTokenInterceptor));
}

void registerRepository() {
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(userRemoteDataSource: getIt()));
  getIt.registerSingleton<QuizRepository>(
      QuizRepositoryImpl(quizDataSource: getIt()));
  getIt.registerSingleton<QuizReportRepository>(
      QuizReportRepositoryImpl(quizReportDataSource: getIt()));
  getIt.registerSingleton<CreateQuizRepository>(
      CreateQuizRepositoryImpl(createQuizDataSource: getIt()));
  getIt.registerSingleton<QuestionManageRepository>(
      QuestionManageRepositoryImpl(questionManageDatasource: getIt()));
}

void registerBloc() {
  getIt.registerFactory(
    () => UserBloc(authRepository: getIt(), userRepository: getIt()),
  );
  getIt.registerFactory(
    () => QuizBloc(quizRepository: getIt()),
  );
  getIt.registerFactory(
    () => QuizReportBloc(quizReportRepository: getIt()),
  );
  getIt.registerFactory(
    () => CreateQuizBloc(createQuizRepository: getIt()),
  );
  getIt.registerFactory(
    () => QuestionManageBloc(questionManageRepository: getIt()),
  );

  getIt.registerFactory(
    () => ThemeBloc(),
  );
}
