import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_notebooks/archive_favorites_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_notebooks/blocs/app_blocs.dart';
import 'package:flutter_application_notebooks/blocs/app_events.dart';
import 'package:flutter_application_notebooks/blocs/app_states.dart';
import 'package:flutter_application_notebooks/detail_screen.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';
import 'package:flutter_application_notebooks/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: RepositoryProvider(
        create: (context) => ProductRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadProductEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notebooks Product Explorer"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 27.0),
              child: IconButton(
                icon: Icon(Icons.archive),
                iconSize: 34, // Ajusta según necesites
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ArchiveScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProductLoadedState) {
              List<ProductModel> productList = state.products;
              return Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0,
                    10.0), 
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        String searchText = value.toLowerCase();
                        // Filter the list of products
                        context
                            .read<ProductBloc>()
                            .add(ApplySearchFilterEvent(filter: searchText));
                      },
                      decoration: const InputDecoration(
                          labelText:
                              'Search (by brands: HP, Apple, Lenovo, etc)',
                          suffixIcon: Icon(Icons.search)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: productList.length,
                          itemBuilder: (_, index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                    onTap: () async {
                                      //Saving the product selected by Shared Preferences
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String productJson = json
                                          .encode(productList[index].toJson());
                                      List<String>? productJsonList =
                                          prefs.getStringList(
                                                  'selected_products') ??
                                              [];
                                      productJsonList.add(productJson);
                                      prefs.setStringList(
                                          'selected_products', productJsonList);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    e: productList[index],
                                                  )));
                                    },
                                    child: Card(
                                      color: Color.fromARGB(255, 122, 178, 224),
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        title: Text(
                                          "${productList[index].price} USD",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          productList[index].title,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        trailing: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              productList[index].imageProduct),
                                        ),
                                      ),
                                    )));
                          }),
                    ),
                  ],
                ),
              );
            }
            if (state is ProductErrorState) {
              return Center(child: Text("Error"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
