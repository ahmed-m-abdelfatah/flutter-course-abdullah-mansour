import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../shared/components/components.dart';
import '../../layout/cubit/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _builder(context, state);
      },
    );
  }

  Widget _builder(context, state) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => _conditionBuilder(context, state),
      widgetBuilder: _widgetBuilder,
      fallbackBuilder: _fallbackBuilder,
    );
  }

  bool _conditionBuilder(BuildContext context, state) {
    // return state is! LoadingFavoritesData;
    return ShopCubit.get(context).favorites.isNotEmpty;
  }

  Widget _widgetBuilder(context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildListProduct(
        ShopCubit.get(context).favoritesModel!.data.data[index].product,
        context,
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
    );
  }

  Widget _fallbackBuilder(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
