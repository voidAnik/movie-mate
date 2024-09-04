import 'package:flutter/material.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(message,
        style: context.textStyle.headlineMedium!.copyWith(
          color: Colors.redAccent
        ),),
      ),
    );
  }
}
