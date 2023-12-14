import 'package:authorization/core/consts/color_constants.dart';
import 'package:authorization/core/consts/path_constants.dart';
import 'package:authorization/core/consts/text_constants.dart';
import 'package:authorization/features/main_screens/chat/view/view.dart';
import 'package:authorization/features/main_screens/search/search.dart';
import 'package:authorization/features/main_screens/settings/settings.dart';
import 'package:authorization/features/main_screens/statistics/view/view.dart';
import 'package:authorization/features/main_screens/workout/workout.dart';
import 'package:authorization/features/tab_bar/bloc/tab_bar_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class TabBarScreen extends StatelessWidget {
  const TabBarScreen({
    super.key,
    required this.transitionIndex,
  });

  final int transitionIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (context) => TabBarBloc(currentIndex: transitionIndex),
      child: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {},
        buildWhen: (_, currState) =>
            currState is TabBarInitial || currState is TabBarItemSelectedState,
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            body: _createBody(context, bloc.currentIndex),
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      fixedColor: ColorConstants.primaryColor,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      iconSize: 40,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      items: [
        BottomNavigationBarItem(
          icon: Image(
            width: 30,
            height: 40,
            image: const AssetImage(PathConstants.workouts),
            color: bloc.currentIndex == 0
                ? ColorConstants.primaryColor
                : Colors.grey,
          ),
          label: TextConstants.workoutsIcon,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: bloc.currentIndex == 1
                ? ColorConstants.primaryColor
                : Colors.grey,
          ),
          label: TextConstants.searchIcon,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: bloc.currentIndex == 2
                ? ColorConstants.primaryColor
                : Colors.grey,
          ),
          label: TextConstants.chatIcon,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.bar_chart_rounded,
            //Icons.insert_chart_outlined_rounded,
            color: bloc.currentIndex == 3
                ? ColorConstants.primaryColor
                : Colors.grey,
          ),
          label: TextConstants.statiscticIcon,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
            color: bloc.currentIndex == 4
                ? ColorConstants.primaryColor
                : Colors.grey,
          ),
          label: TextConstants.settingsIcon,
        ),
      ],
      onTap: (index) {
        bloc.add(TabBarItemTappedEvent(index: index));
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      WorkoutScreen(),
      SearchScreen(),
      ChatScreen(),
      StatisticsScreen(),
      SettingsScreen(),
    ];
    return children[index];
  }
}
