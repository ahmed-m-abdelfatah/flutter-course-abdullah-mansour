import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/shop_cubit.dart';
import '../../models/categories_model.dart';

class CateogriesScreen extends StatelessWidget {
  CateogriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _builder(context);
      },
    );
  }

  ListView _builder(context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => _buildCategoryItem(
        ShopCubit.get(context).categoriesModel!.data.data[index],
      ),
      separatorBuilder: (context, index) => Divider(),
      itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
    );
  }

  Padding _buildCategoryItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20),
          Text(
            model.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
