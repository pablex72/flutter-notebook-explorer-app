import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_notebooks/blocs/app.blocs.dart';
import 'package:flutter_application_notebooks/blocs/app_events.dart';
import 'package:flutter_application_notebooks/blocs/app_states.dart';
import 'package:flutter_application_notebooks/detail_screen.dart';
import 'package:flutter_application_notebooks/models/user_model.dart';
import 'package:flutter_application_notebooks/repos/repositories.dart';

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
          title: const Text("Notebooks Product Explorer v1"),
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: (value) {
                        String searchText = value.toLowerCase();
                        // Filtrar la lista de usuarios en función del criterio de búsqueda
                        context
                            .read<ProductBloc>()
                            .add(ApplySearchFilterEvent(filter: searchText));
                      },
                      decoration: InputDecoration(
                          labelText: 'Search', suffixIcon: Icon(Icons.search)),
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
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    e: productList[index],
                                                  )));
                                    },
                                    child: Card(
                                      color: Colors.blue,
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: ListTile(
                                        title: Text(
                                          productList[index].price,
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
