import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_coffee/config/services.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/presentation/favorite_coffee/cubit/favorite_coffee_cubit.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';
import 'package:random_coffee/presentation/random_coffee/random_coffee.dart';

import '../../test_services.dart';

void main() {
  initializeServices();

  group('FavoriteCoffeeCubit', () {
    test('initial state is empty', () {
      expect(FavoriteCoffeeCubit().state, []);
    });

    blocTest<FavoriteCoffeeCubit, List<String>>(
      'emits array of urls object when getFavoriteCoffeesUrls is called',
      build: FavoriteCoffeeCubit.new,
      act: (cubit) => cubit.getFavoriteCoffeesUrls(),
      verify: (cubit) {
        expect(cubit.state, fakeFavorites);
      }
    );
  });
}