// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:game_app/core/theme/app_colors.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_state.dart';
//
// class QuizTopAreaWidget extends StatelessWidget {
//
//
//   const QuizTopAreaWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuizBloc, QuizState>(
//       builder: (context, state) {
//         final currentQuestionIndex = state.currentQuestionIndex;
//
//
//
//         return Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.pureWhite.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                       color: Colors.white.withOpacity(0.2),
//                     ),
//                   ),
//                   child: Text(
//                     'Q. ${currentQuestionIndex + 1}/${state.quizQuestionList?.length}',
//                     style:  TextStyle(
//                       color: AppColors.pureWhite,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: LinearProgressIndicator(
//                 value: (currentQuestionIndex + 1) /
//                         (state.quizQuestionList!.length) ??
//                     1,
//                 backgroundColor: AppColors.pureWhite.withOpacity(0.1),
//                 valueColor:
//                  AlwaysStoppedAnimation<Color>(AppColors.peachOrange),
//                 minHeight: 8,
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
