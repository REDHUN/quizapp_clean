// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:game_app/core/di/get_it.dart';
// import 'package:game_app/core/router/app_router.dart';
// import 'package:game_app/core/theme/app_colors.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
// import 'package:game_app/features/quiz/presentation/pages/quiz_attend_page/widgets/quiz_answer_container.dart';
// import 'package:game_app/features/quiz/presentation/pages/quiz_attend_page/widgets/quiz_top_area_widget.dart';
// import 'package:game_app/features/quiz/presentation/pages/quiz_result_page/quiz_result_page.dart';
//
// import '../../bloc/quiz_state.dart';
//
// class QuizAttendPage extends StatefulWidget {
//   final int quizId;
//
//   const QuizAttendPage({super.key, required this.quizId});
//
//   static String route = '/quizAttend:quizId';
//
//   @override
//   State<QuizAttendPage> createState() => _QuizAttendPageState();
// }
//
// class _QuizAttendPageState extends State<QuizAttendPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   int score = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     );
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           getIt<QuizBloc>()..add(GetQuizQuestionsEvent(quizId: widget.quizId)),
//       child: Scaffold(
//         body: BlocConsumer<QuizBloc, QuizState>(
//           listener: (context, state) {
//             if(state.status==QuizStatus.questionCompleted){
//               AppRouter.router.go(QuizResultPage.route);
//             }
//           },
//           builder: (context, state) {
//             final currentQuestionIndex = state.currentQuestionIndex;
//             if (state.status == QuizStatus.questionLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state.status == QuizStatus.questionLoadError) {
//               return Text("Question Load Error");
//             } else if (state.status == QuizStatus.questionLoadSuccess) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: AppColors.quizAttendPageGradient),
//                 ),
//                 child: SafeArea(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         QuizTopAreaWidget(
//                         ),
//                         const SizedBox(height: 40),
//                         FadeTransition(
//                           opacity: _animation,
//                           child: Container(
//                             padding: const EdgeInsets.all(24),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withValues(alpha: 0.1),
//                               borderRadius: BorderRadius.circular(24),
//                               border: Border.all(
//                                 color: Colors.white.withOpacity(0.2),
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.1),
//                                   blurRadius: 20,
//                                   offset: const Offset(0, 10),
//                                 ),
//                               ],
//                             ),
//                             child: Text(
//                               state.quizQuestionList?[currentQuestionIndex]
//                                       .question ??
//                                   "",
//                               style: TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.pureWhite,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 40),
//
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: state
//                           .quizQuestionList?[currentQuestionIndex].options?.length??0 ,
//                         itemBuilder: (context, index) {
//                         return    QuizAnswerContainer(
//                           optionNumber: "${index+1}",
//                           animation: _animation,
//                           questionOption: state
//                               .quizQuestionList?[currentQuestionIndex].options?[index].text??
//                               "",
//                         );
//                       },)
//
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return Container(
//                 child: Center(child: Text("dd")),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
