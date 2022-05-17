import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_quiz_app/controller/quiz/quiz_controller.dart';
import 'package:flutter_riverpod_quiz_app/models/failure_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/quiz/quiz_state.dart';
import '../enums/difficulty.dart';
import '../models/question_model.dart';
import '../repositories/quiz/quiz_repository.dart';
import '../widgets/quiz_error.dart';
import '../widgets/quiz_questions.dart';
import '../widgets/quiz_results.dart';

final quizQuestionsProvider = FutureProvider.autoDispose<List<Question>>(
  (ref) => ref.watch(quizRepositoryProvider).getQuestions(
        numQuestions: 5,
        categoryId: Random().nextInt(24) + 9,
        difficulty: Difficulty.any,
      ),
);

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizQuestions = useProvider(quizQuestionsProvider);
    final pageController = usePageController();

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 41, 164, 51),
            Color.fromARGB(255, 127, 34, 214),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: quizQuestions.when(
          data: (questions) => _buildBody(context, pageController, questions),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, _) => QuizError(
            message: error is Failure ? error.message : 'Something went wrong!',
          ),
        ),
        bottomSheet: quizQuestions.maybeWhen(
          data: (questions) {
            final quizState = useProvider(quizQuestionsProvider.state);
            if (!quizState.answered) return const SizedBox.shrink();
            return CustomButton(
                title: pageController.page!.toInt() + 1 < questions.length
                    ? 'Next Question'
                    : 'See Results',
                onTap: () {});
          },
          orElse: () => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    PageController pageController,
    List<Question> questions,
  ) {
    if (questions.isEmpty) return QuizError(message: 'No questions found.');

    final quizState = useProvider(quizControllerProvider.state);
    return quizState.status == QuizStatus.complete
        ? QuizResults(state: quizState, questions: questions)
        : QuizQuestions(
            pageController: pageController,
            state: quizState,
            questions: questions,
          );
  }
}
