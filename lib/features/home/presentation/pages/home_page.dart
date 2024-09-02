
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/features/home/presentation/widgets/upcoming_slider_view_widget.dart';
import 'package:movie_mate/features/home/presentation/widgets/trending_movies_widget.dart';


class HomePage extends StatelessWidget {
  static const String path = '/homepage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 4.0,
        backgroundColor: context.theme.primaryColor,
        title: Text('MovieMeta',
          style: GoogleFonts.aldrich(
            fontSize: context.width * 0.05,
            color: Colors.red
          ),
        ),
        centerTitle: true,
        leading: Container(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(Icons.menu_rounded, color: context.theme.appBarTheme.iconTheme!.color),
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
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body:_createBody(context),
    );
  }

  Widget _createBody(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Column(
          children: [
            UpcomingSliderView(
              actionOpenMovie: (movie) {

              },
            ),
            const Divider(height: 6.0, color: Colors.transparent),
            Expanded(child: const TrendingMoviesWidget()),
          ],
        );
      },
    );
  }
}
