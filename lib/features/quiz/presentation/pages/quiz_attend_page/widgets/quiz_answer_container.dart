// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:game_app/core/theme/app_colors.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_bloc.dart';
// import 'package:game_app/features/quiz/presentation/bloc/quiz_event.dart';
//
//
// class QuizAnswerContainer extends StatelessWidget {
//   final Animation<double> animation;
//   final String optionNumber;
//   final String questionOption;
//
//   const QuizAnswerContainer(
//       {super.key, required this.animation, required this.questionOption,required this.optionNumber});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: FadeTransition(
//         opacity: animation,
//         child: ElevatedButton(
//           onPressed: () {
//             context.read<QuizBloc>().add(
//                GetQuizNextQuestionEvent());
//           },
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.all(20),
//             backgroundColor: AppColors.pureWhite,
//             foregroundColor: AppColors.midnightBlue,
//             elevation: 4,
//             shadowColor: Colors.black.withOpacity(0.2),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//             ),
//             side: BorderSide(
//               color: AppColors.pureWhite,
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 30,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   color: AppColors.midnightBlue.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Center(
//                   child: Text(
//                     optionNumber,
//                     // String.fromCharCode(65 + index),
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF2D3250),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Text(questionOption,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
