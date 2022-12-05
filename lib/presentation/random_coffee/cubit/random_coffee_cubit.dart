import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';

class RandomCoffeeCubit extends Cubit<CoffeeState> {

  RandomCoffeeCubit(this._coffeeImageUseCase) : super(LoadingCoffee());

  final CoffeeImageUseCase _coffeeImageUseCase;

  Future<void> getRandomCoffeeImage() async {
    emit(LoadingCoffee());
    try {
      final coffee = await _coffeeImageUseCase.getRandomCoffeeImage();
      emit(LoadedCoffee(url: coffee.file));
    } catch (e) {
      emit(CoffeeError('test error'));
    }
  }

  Future<void> addCoffeeToFavorite() async {
    if (state is LoadedCoffee) {
      final url = (state as LoadedCoffee).url;
      try {
        final res = await _coffeeImageUseCase.addCoffeeToFavorite(url);
        res
            ? emit(LoadedCoffee(url: url, favorite: true))
            : emit(CoffeeError('Error adding image to favorite.'));
      } catch (e) {
        emit(CoffeeError('Error adding image to favorite.'));
      }
    } else {
      log('RandomCoffeeCubit.addCoffeeToFavorite : no coffee currently loaded');
    }
  }
}

