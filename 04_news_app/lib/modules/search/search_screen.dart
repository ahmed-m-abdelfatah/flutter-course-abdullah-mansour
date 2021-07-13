import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/news_cubit.dart';
import '../../shared/components/components.dart';

//ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit searchCubit = NewsCubit.get(context);
        var list = searchCubit.search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  label: 'Search',
                  prefix: Icons.search,
                  type: TextInputType.text,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search Must Not Be Empty';
                    }
                  },
                  onChange: (String value) {
                    searchCubit.getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
