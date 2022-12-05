import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_coffee/l10n/l10n.dart';
import 'package:random_coffee/presentation/favorite_coffee/cubit/favorite_coffee_cubit.dart';

class FavoriteCoffeePage extends StatelessWidget {
  const FavoriteCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCoffeeCubit(),
      child: const FavoriteCoffeesView(),
    );
  }
}

class FavoriteCoffeesView extends StatelessWidget {
  const FavoriteCoffeesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favoriteCoffeeAppBarTitle),
      ),
      body: FutureBuilder<List<String>>(
          future: context.read<FavoriteCoffeeCubit>().getFavoriteCoffeesUrls(),
          builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, pos) {
                    return FavoriteCoffeeImage(url: snapshot.data![pos]);
                  },)
              : Center(child: Text(l10n.noFavoriteCoffees));
            }
            if (snapshot.hasError) {
              log('Error: ${snapshot.runtimeType},'
                  '${snapshot.error}, ${snapshot.stackTrace}');
            }
            return const Center(child: CircularProgressIndicator());
          },),
    );
  }
}

class FavoriteCoffeeImage extends StatelessWidget {
  const FavoriteCoffeeImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Image.file(File(url), errorBuilder: (context, object, stackTrace) {
        log('Error on Image.file(): $stackTrace');
        return Container();
      },),
    );
  }
}
