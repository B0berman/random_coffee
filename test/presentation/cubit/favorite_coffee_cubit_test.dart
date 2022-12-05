import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/favorite_coffee/cubit/favorite_coffee_cubit.dart';
import 'package:random_coffee/presentation/shared/list_state.dart';

import '../../test_services.dart';

void main() {
  initializeServices();

  group('FavoriteCoffeeCubit', () {
    test('initial state is empty', () {
      expect(FavoriteCoffeeCubit(services<CoffeeImageUseCase>()).state.status,
          ListStatus.loading);
    });

    blocTest<FavoriteCoffeeCubit, ListState<String>>(
      'emits array of urls object when getFavoriteCoffeesUrls is called',
      build: () => FavoriteCoffeeCubit(services<CoffeeImageUseCase>()),
      act: (cubit) => cubit.getFavoriteCoffeesUrls(),
      verify: (cubit) {
        expect(cubit.state.items, fakeFavorites);
      }
    );
  });
}