import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/search_cubit.dart';
import '../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _foemKey = GlobalKey<FormState>();
    var _searchController = TextEditingController();

    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: _foemKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: _searchController,
                        type: TextInputType.text,
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Search Text Must Not Be Empty';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefix: Icons.search,
                        onSubmit: (String text) {
                          SearchCubit.get(context)
                              .getSearchData(searchText: text);
                        },
                      ),
                      const SizedBox(height: 10),
                      if (state is LoadingSearchData) LinearProgressIndicator(),
                      if (state is SuccessSearchData)
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data
                                  .data[index],
                              context,
                              isOldPrice: false,
                            ),
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data
                                .data
                                .length,
                          ),
                        )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
