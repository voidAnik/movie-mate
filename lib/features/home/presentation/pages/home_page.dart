import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mate/config/theme/colors.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/features/home/presentation/widgets/slider_view_widget.dart';


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
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              children: [
                SliderView(
                  actionOpenMovie: (movie) {

                  },
                ),
                /*Divider(height: 4.0, color: Colors.transparent),
                CategoryView(
                  actionOpenCategory: (movie) {
                    _openMovieDetail(movie);
                  },
                ),
                Divider(height: 8.0, color: Colors.transparent),
                MyListView(
                  actionOpenMovie: (movie) {
                    _openMovieDetail(movie);
                  },
                  actionLoadAll: () {},
                ),
                Divider(height: 8.0, color: Colors.transparent),
                PopularView(
                  actionOpenMovie: (movie) {
                    _openMovieDetail(movie);
                  },
                  actionLoadAll: () {},
                ),*/
              ],
            ),
          ),
        );
      },
    );
  }
}
