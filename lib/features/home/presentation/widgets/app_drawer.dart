import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_mate/config/routes/router_manager.dart';
import 'package:movie_mate/core/constants/strings.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/features/favorites/presentation/pages/favorite_movie_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(context),
          _createDrawerItem(
            context,
            icon: Icons.favorite,
            text: LocaleKeys.favoriteMovies.tr(),
            onTap: () {
              Navigator.pop(context);
              // Navigate to favorite movies page
              _navigateToFavoritePage(context);
            },
          ),
          _createDrawerItem(
            context,
            icon: Icons.location_on,
            text: LocaleKeys.nearbyTheatres.tr(),
            onTap: () {
              Navigator.pop(context);
              // Navigate to nearby theaters page
              _navigateToNearbyTheatrePage(context);
            },
          ),
          _createDrawerItem(
            context,
            icon: Icons.settings,
            text: LocaleKeys.settings.tr(),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings page
              _navigateToSettingsPage(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        boxShadow: [
      BoxShadow(
      color: context.theme.colorScheme.primary.withOpacity(0.2),
      spreadRadius: 2,
      blurRadius: 8,
      offset: const Offset(0, 2), // changes position of shadow
    ),
    ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: context.theme.colorScheme.onPrimary,
            child: Icon(
              Icons.movie,
              size: 36,
              color: context.theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.aldrich(
                fontSize: context.width * 0.05,
                color: context.theme.colorScheme.onPrimary,
            ),
          ),
          Text(
            LocaleKeys.slogan.tr(),
            style: GoogleFonts.kalam(
              fontSize: context.width * 0.03,
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, {
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text,
            style: context.textStyle.titleMedium,),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  void _navigateToFavoritePage(BuildContext context) {
    context.push(FavoriteMoviePage.path);
  }

  void _navigateToNearbyTheatrePage(BuildContext context) {}

  void _navigateToSettingsPage(BuildContext context) {}
}
