import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repositories/quiz/quiz_repository.dart';

class QuizError extends StatelessWidget {
  final String message;
  const QuizError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 20),
          CustomButton(
            title: 'Retry',
            onTap: () => context.refresh(quizRepositoryProvider),
          )
        ],
      ),
    );
  }
}

final List<BoxShadow> boxShadow = const [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4,
  ),
];

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
