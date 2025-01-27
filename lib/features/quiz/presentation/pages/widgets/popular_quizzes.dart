import 'package:flutter/material.dart';
import 'package:game_app/core/router/app_router.dart';
import 'package:game_app/core/theme/grediant.dart';
import 'package:game_app/features/quiz/domain/model/quiz_model/quiz_model.dart';


class PopularQuizzes extends StatelessWidget {

  final List<QuizModel> quizList;
  const PopularQuizzes({super.key,required this.quizList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Quizzes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quizList.length,
            itemBuilder: (context, index) {
              final colors = [
                const Color(0xFF6366F1),
                const Color(0xFFEC4899),
                const Color(0xFF14B8A6),
                const Color(0xFFF59E0B),
                const Color(0xFF8B5CF6),
              ];
              final color = colors[index % colors.length];

              return Container(
                width: 160,
                margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                child: Card(
                  elevation: Theme.of(context).brightness == Brightness.dark ? 2 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: Theme.of(context).brightness == Brightness.dark
                            ? [
                          GradientColors.getRandomGradient()[0].withOpacity(0.7),
                          GradientColors.getRandomGradient()[1].withOpacity(0.7),
                        ]
                            :  GradientColors.getRandomGradient(),
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: Theme.of(context).brightness == Brightness.dark
                          ? null
                          : [
                        BoxShadow(
                          color:   GradientColors.getRandomGradient()[0].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Theme.of(context).brightness == Brightness.dark
                          ? Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      )
                          : null,
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          AppRouter.router.push('/quizAttend${quizList[index].id??""}');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.1 : 0.2),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Theme.of(context).brightness == Brightness.dark
                                      ? Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 1,
                                  )
                                      : null,
                                ),
                                child: Icon(
                                Icons.quiz,
                                  color: Colors.white.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.9 : 1),
                                  size: 28,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                quizList[index].title??"",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.9 : 1),
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${quizList[index].totalQuestions} Questions',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.7 : 0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

                // InkWell(
                // onTap: (){
                //
                //   AppRouter.router.push('/quizAttend${quizList[index].id??""}');
                // },
                // child:
                //
                // Container(
                //   width: 160,
                //   margin: const EdgeInsets.only(right: 16),
                //   child: Card(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //
                //
                //         Container(
                //           height: 100,
                //           decoration: BoxDecoration(
                //             gradient: LinearGradient(
                //               colors: [
                //                 color,
                //                 color.withOpacity(0.8),
                //               ],
                //               begin: Alignment.topLeft,
                //               end: Alignment.bottomRight,
                //             ),
                //             borderRadius: const BorderRadius.vertical(
                //               top: Radius.circular(12),
                //             ),
                //           ),
                //           child: const Center(
                //             child: Icon(
                //               Icons.quiz,
                //               size: 40,
                //               color: Colors.white,
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //         quizList[index].title??"",
                //                 style: const TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //               ),
                //               const SizedBox(height: 4),
                //               Text(
                //                 quizList[index].totalQuestions?.toString()??"",
                //                 style: TextStyle(
                //                   color: Colors.grey[600],
                //                   fontSize: 12,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

            },
          ),
        ),
      ],
    );
  }

}
