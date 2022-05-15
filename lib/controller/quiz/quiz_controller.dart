import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/question_model.dart';
import 'quiz_state.dart';

final quizControllerProvider = StateNotifierProvider.autoDispose<QuizController, dynamic>((ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());
  void submitAnswer(Question currentCuestion, String answer) {
    if (state.answered) return;
    if (currentCuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.correct..add(currentCuestion),
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.correct..add(currentCuestion),
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}
