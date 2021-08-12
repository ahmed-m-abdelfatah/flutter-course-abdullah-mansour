import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_router.dart';
import 'cubit/shop_cubit.dart';

class HomeLayoutScreen extends StatelessWidget {
  HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit shopCubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('SHOP'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  _goToSearchScreen(context);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: shopCubit.screens[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            onTap: (int index) {
              shopCubit.changeBottomNavigationBarItems(index);
            },
            items: shopCubit.bottomNavigationBarItems,
          ),
        );
      },
    );
  }

  void _goToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, AppRouter.searchScreen);
  }
}
