import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/core/extensions/context_extension.dart';
import 'package:movie_mate/core/injection/injection_container.dart';
import 'package:movie_mate/core/language/generated/locale_keys.g.dart';
import 'package:movie_mate/core/utils/genre_service.dart';
import 'package:movie_mate/features/settings/presentation/blocs/selected_genre_cubit.dart';

class GenreSelectionButton extends StatelessWidget {
  final List<int> selectedGenres;

  const GenreSelectionButton({super.key, required this.selectedGenres});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(LocaleKeys.selectGenre.tr(),
        style: context.textStyle.titleMedium,),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        _showGenreSelectionBottomSheet(context, selectedGenres);
      },
    );
  }

  void _showGenreSelectionBottomSheet(BuildContext parentContext, List<int> selectedGenres) {
    showModalBottomSheet(
      context: parentContext,
      builder: (context) {
        return GenreSelectionSheet(
          selectedGenres: selectedGenres,
          parentContext: parentContext,
        );
      },
    );
  }
}

class GenreSelectionSheet extends StatefulWidget {
  final List<int> selectedGenres;
  final BuildContext parentContext;

  const GenreSelectionSheet({super.key, required this.selectedGenres, required this.parentContext});

  @override
  State<GenreSelectionSheet> createState() => _GenreSelectionSheetState();
}

class _GenreSelectionSheetState extends State<GenreSelectionSheet> {
  late List<int> _selectedGenres;

  @override
  void initState() {
    super.initState();
    _selectedGenres = List.from(widget.selectedGenres); // Initialize with selected genres
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.selectGenre.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              children: _buildGenreList(),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  log('saving...');
                  // Save the selected genres
                  widget.parentContext.read<SelectedGenreCubit>().saveGenres(genreIds: _selectedGenres);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saving successful!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  backgroundColor: context.theme.colorScheme.primary, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0), // Rounded corners
                  ),
                  elevation: 4.0, // Shadow elevation
                ),
                child: Text(LocaleKeys.save.tr(), style: context.textStyle.titleMedium,),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGenreList() {
    // Use the GenreService to get all genres
    final allGenres =getIt<GenreService>().genreMap;

    return allGenres.entries.map((entry) {
      final genreId = entry.key;
      final genreName = entry.value;
      final isSelected = _selectedGenres.contains(genreId);

      return ListTile(
        title: Text(genreName),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (isChecked) {
            setState(() {
              if (isChecked == true) {
                if (!_selectedGenres.contains(genreId)) {
                  _selectedGenres.add(genreId);
                }
              } else {
                _selectedGenres.remove(genreId);
              }
            });
          },
        ),
      );
    }).toList();
  }
}