import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import 'cubit/news_cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomNavigationBarItems,
            onTap: (index) => cubit.changeBottomNavigationBarItems(index),
          ),
        );
      },
    );
  }
}
