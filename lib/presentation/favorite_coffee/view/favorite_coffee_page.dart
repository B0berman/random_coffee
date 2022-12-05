import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_coffee/config/services.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/l10n/l10n.dart';
import 'package:random_coffee/presentation/favorite_coffee/cubit/favorite_coffee_cubit.dart';
import 'package:random_coffee/presentation/shared/list_state.dart';

class FavoriteCoffeePage extends StatelessWidget {
  const FavoriteCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final useCases = injector<CoffeeImageUseCase>();
    return BlocProvider(
      create: (_) => FavoriteCoffeeCubit(useCases)..getFavoriteCoffeesUrls(),
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
      body: BlocBuilder<FavoriteCoffeeCubit, ListState<String>>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              return state.items.isNotEmpty ? ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, pos) {
                  return FavoriteCoffeeImage(url: state.items[pos]);
                },)
                  : Center(child: Text(l10n.noFavoriteCoffees));
            } else if (state.status == ListStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(child: Text(''));
          }
      ),
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
