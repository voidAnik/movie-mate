import 'package:flutter/material.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';


class HomePage extends StatelessWidget {
  static const String path = '/homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: primaryColor,
        title: Text('MovieMate',
          style: context.textStyle.headlineMedium,
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(Icons.menu_rounded, color: actionBarIconColor),
            onPressed: () {},
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search, color: actionBarIconColor),
              onPressed: () {},
            ),
          ),
        ],
        elevation: 0.0,
      ),
      backgroundColor: backgroundColor,
      body:Container(),
    );
  }
}
