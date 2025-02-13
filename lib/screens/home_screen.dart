import 'dart:developer';
import 'package:final_task/functions/notify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_task/data/data_cubit/data_cubit.dart';
import 'package:final_task/data/data_cubit/data_cubit_states.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DataCubit()..getProducts(),
      child: BlocConsumer<DataCubit, DataStates>(
        listener: (context, state) {
          if (state is DataErrorState) {
            notify(context, "Something went wrong, try again later");
            log(state.error);
          }
        },
        builder: (context, state) {
          DataCubit dataCubit = context.read<DataCubit>();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              centerTitle: true,
              leading: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: state is DataLoadingState
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  itemCount: dataCubit.products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(
                        vertical: 10
                      ),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 15,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                dataCubit.products[index].image,
                                fit: BoxFit.fill,
                              ),
                            )
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataCubit.products[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Price:',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      )
                                    ),
                                    Text(
                                      '\$${dataCubit.products[index].price.toString()}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      )
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove_circle_outline,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              dataCubit.decrement(index);
                                            }
                                          ),
                                          Text(
                                            dataCubit.products[index].quantity.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20
                                            )
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              dataCubit.increment(index);
                                            }
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Total: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            '\$'+(dataCubit.products[index].quantity*dataCubit.products[index].price).toStringAsFixed(2),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    );
                  }
                ),
              )
          );
        },
      ),
    );
  }
}
