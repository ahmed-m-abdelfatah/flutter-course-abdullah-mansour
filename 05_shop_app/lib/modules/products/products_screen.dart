import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../layout/cubit/shop_cubit.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/my_main_styles.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is SuccessChangeFavoritesDataRemote) {
          if (!state.changeFavoritesModel.status) {
            showToast(
              text: state.changeFavoritesModel.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: _conditionBuilder,
          widgetBuilder: _widgetBuilder,
          fallbackBuilder: _fallbackBuilder,
        );
      },
    );
  }

  bool _conditionBuilder(BuildContext context) {
    return ShopCubit.get(context).homeModel != null &&
        ShopCubit.get(context).categoriesModel != null;
  }

  Widget _widgetBuilder(context) {
    return _productsBuilder(
      context,
      ShopCubit.get(context).homeModel,
      ShopCubit.get(context).categoriesModel,
    );
  }

  Widget _productsBuilder(
    BuildContext context,
    HomeModel? model,
    CategoriesModel? categoriesModel,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data.banners.map(
              (e) {
                return Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ).toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _buildCategoryItem(
                      categoriesModel!.data.data[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: categoriesModel!.data.data.length,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: MyMainColors.myGrey,
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                model.data.products.length,
                (index) => _buildGridProduct(
                  model.data.products[index],
                  context,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Stack _buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: MyMainColors.myWhite),
          ),
        )
      ],
    );
  }

  Container _buildGridProduct(ProductModel model, context) {
    return Container(
      color: MyMainColors.myWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if (model.discount != 0)
                Container(
                  color: MyMainColors.myRed,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Discount ${_calculateDiscount(model)}%',
                    style: TextStyle(
                      fontSize: 8,
                      color: MyMainColors.myWhite,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        color: MyMainColors.myBlue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.3,
                          color: MyMainColors.myGrey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            ShopCubit.get(context).favorites[model.id]!
                                ? MyMainColors.myBlue
                                : MyMainColors.myGrey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: MyMainColors.myWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _calculateDiscount(ProductModel model) {
    dynamic cal = ((model.oldPrice.round() - model.price.round()) /
            model.oldPrice.round()) *
        100;
    return cal.floor();
  }

  Widget _fallbackBuilder(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
