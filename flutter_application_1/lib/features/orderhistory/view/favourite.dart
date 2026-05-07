import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_cubit.dart';
import 'package:flutter_application_1/cubits/favourite/favourite_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favourite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Favorites")),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {

          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(child: Text(state.message));
          }

          if (state is FavoriteLoaded || state is FavoriteUpdated) {
            final products = context.read<FavoriteCubit>().favoriteProducts;

            if (products.isEmpty) {
              return Center(child: Text("No Favorites Yet ❤️"));
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

           return ListTile(
  leading: product['thumbnail'] != null
      ? Image.network(product['thumbnail'], width: 60, fit: BoxFit.cover)
      : const Icon(Icons.image),
  title: Text(product['title'] ?? ''),
  subtitle: Text("${product['price']} LE"),
  trailing: IconButton(
    icon: const Icon(Icons.favorite, color: Colors.red),
    onPressed: () {
      context.read<FavoriteCubit>().toggleFavorite(product['id']);
    },
  ),
);
              },
            );
          }

          return Center(child: Text("No Favorites Yet ❤️"));
        },
      ),
    );
  }
}