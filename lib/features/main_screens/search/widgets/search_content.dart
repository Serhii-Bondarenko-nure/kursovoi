import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/features/main_screens/search/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:authorization/features/main_screens/search/widgets/workout_category_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(TextConstants.searchIcon)),
        automaticallyImplyLeading: false,
      ),
      body: _createMainData(context),
    );
  }

  Widget _createMainData(context) {
    final searchBloc = BlocProvider.of<SearchScreenBloc>(context);
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is TypesListLoaded) {
          final workoutTypesList = state.types.typesList;

          return ListView.separated(
            padding: const EdgeInsets.only(
              top: 12,
              bottom: 5,
              left: 16,
              right: 16,
            ),
            itemCount: workoutTypesList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemBuilder: (context, i) {
              return WorkoutCategoryTile(workoutType: workoutTypesList[i]);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
