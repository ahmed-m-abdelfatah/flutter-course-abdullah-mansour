import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/search_model.dart';
import '../../../shared/network/local/cache_data.dart';
import '../../../shared/network/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchData({
    required String searchText,
  }) {
    emit(LoadingSearchData());

    DioHelper.postData(
      path: ApiDataAndEndPoints.searchProductsPathUrl,
      token: token,
      data: {
        'text': searchText,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchData());
    }).catchError((error) {
      print('getSearchData -- ${error.toString()}');
      emit(ErrorSearchData(error.toString()));
    });
  }
}
