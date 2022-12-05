import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_coffee/config/services.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/l10n/l10n.dart';
import 'package:random_coffee/presentation/favorite_coffee/view/favorite_coffee_page.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_cubit.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';

class RandomCoffeePage extends StatelessWidget {
  const RandomCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final useCases = injector<CoffeeImageUseCase>();
    return BlocProvider(
      create: (_) => RandomCoffeeCubit(useCases)..getRandomCoffeeImage(),
      child: const RandomCoffeeView(),
    );
  }
}

class RandomCoffeeView extends StatelessWidget {
  const RandomCoffeeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.randomCoffeeAppBarTitle),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                const FavoriteCoffeePage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.favorite),
            ),
          )
        ],
      ),
      body: const Center(child: CoffeeImage(),),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          FloatingActionButton(
            onPressed: () => context.read<RandomCoffeeCubit>().getRandomCoffeeImage(),
            child: const Icon(Icons.refresh, color: Colors.white),
          ),
          const Divider(),
          FloatingActionButton(
            heroTag: 'fab',
            onPressed: () => context.read<RandomCoffeeCubit>().addCoffeeToFavorite(),
            child: const Icon(Icons.favorite_border_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomCoffeeCubit, CoffeeState>(
        builder: (context, state) {
          if (state is LoadedCoffee) {
            return Image.network(state.url,
              errorBuilder: (context, object, f) {
                log('Error on Image.network(): $f');
                return Container();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }},
            );
          } else if (state is CoffeeError) {
            context.read<RandomCoffeeCubit>().getRandomCoffeeImage();
            log('Error loading coffee: ${state.error})');
          }
          return const CircularProgressIndicator();
        }
    );
  }
}
