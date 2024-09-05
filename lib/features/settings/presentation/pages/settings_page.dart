import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movie_mate/core/blocs/theme_cubit.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/core/widgets/shimmer_loading.dart';
import 'package:movie_mate/features/favorites/presentation/blocs/favorite_movies_cubit.dart';
import 'package:movie_mate/features/settings/presentation/blocs/selected_genre_cubit.dart';
import 'package:movie_mate/features/settings/presentation/pages/genre_selection_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String path = '/settings_page';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<SelectedGenreCubit>()..fetchGenres(),
        ),
      ],
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.settings.tr(),
          style: context.textStyle.titleMedium!.copyWith(
            fontSize: context.width * 0.05,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 16),
        children: [
          const LanguageSelector(),
          const Divider(),
          BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, themeMode) {
            return SwitchListTile(
              title: Text('Theme',
                style: context.textStyle.titleMedium,),
              subtitle: Text(
                themeMode == ThemeMode.light
                    ? 'Light'
                    : 'Dark',
                style: context.textStyle.titleSmall,
              ),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          }),
          const Divider(),
          BlocBuilder<SelectedGenreCubit, DataState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return _shimmerSelection();
              } else if (state is DataError) {
                return Center(child: Text(state.error));
              } else if (state is DataSuccess<List<int>>) {
                return GenreSelectionButton(selectedGenres: state.data);
              } else {
                return const Center(child: Text('No data'));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _shimmerSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ShimmerLoading(
          child: ListTile(
        tileColor: Colors.grey[300],
      )),
    );
  }
}

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Language',
        style: context.textStyle.titleMedium,
      ),
      trailing: DropdownButton<String>(
        value: context.locale.languageCode,
        items: const [
          DropdownMenuItem(value: 'en', child: Text('English')),
          // Add more languages here
        ],
        onChanged: (value) {
          // changing localization
          if (value != null) {
            context.setLocale(Locale(value));
          }
        },
      ),
    );
  }
}
