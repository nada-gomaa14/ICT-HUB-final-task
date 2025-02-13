import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:final_task/data/data_cubit/data_cubit_states.dart';
import 'package:final_task/data/models/product_model.dart';


class DataCubit extends Cubit<DataStates> {
  DataCubit(): super(DataInitialState());

  Dio dio = Dio();
  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(DataLoadingState());
    try {
      final url = 'https://fakestoreapi.com/products';
      Response response = await dio.get(url);
      if(response.statusCode == 200) {
        emit(DataSuccessState());
        final List<dynamic> data = response.data;
        for(var map in data) {
          ProductModel product = ProductModel.fromJson(json: map);
          products.add(product);
        }
      }
    }
    catch (e) {
      emit(DataErrorState(error: e.toString()));
    }
  }

  void increment(int index) {
    if(products[index].quantity < 10) {
      products[index].quantity++;
      emit(QuantityIncrementState());
    }
  }

  void decrement(int index) {
    if(products[index].quantity > 1) {
      products[index].quantity--;
      emit(QuantityDecrementState());
    }
  }
}