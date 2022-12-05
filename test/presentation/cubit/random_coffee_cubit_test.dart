import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';
import 'package:random_coffee/presentation/random_coffee/random_coffee.dart';

import '../../test_services.dart';

class MockCoffeeImageUseCase extends Mock implements CoffeeImageUseCase {}
class MockDio extends Mock implements Dio {}

void main() {
  initializeServices();

  const image = 'image';

  final coffeeImageUseCase = services<CoffeeImageUseCase>();

  group('RandomCoffeeCubit', () {
    setUp(() {
      when(coffeeImageUseCase.getRandomCoffeeImage).thenAnswer((_) => Future.value(coffeeImage));
      when(() => coffeeImageUseCase.addCoffeeToFavorite(image)).thenAnswer((_) => Future.value(true));
    });

    test('initial state is empty', () {
      expect(RandomCoffeeCubit(coffeeImageUseCase).state.runtimeType, equals(LoadingCoffee));
    });

    blocTest<RandomCoffeeCubit, CoffeeState>(
      'emits CoffeeLoaded state object when getRandomCoffeeImage is called',
      build: () => RandomCoffeeCubit(coffeeImageUseCase),
      act: (cubit) async {
        await cubit.getRandomCoffeeImage();
      },
      verify: (cubit) {
        verify(coffeeImageUseCase.getRandomCoffeeImage).called(1);
        expect(cubit.state.runtimeType, LoadedCoffee);
      }
    );

    blocTest<RandomCoffeeCubit, CoffeeState>(
        'emits CoffeeError state object when getRandomCoffeeImage is called',
        build: () => RandomCoffeeCubit(coffeeImageUseCase),
        act: (cubit) => cubit.getRandomCoffeeImage(),
        setUp: () => when(() => services<CoffeeImageUseCase>()
            .getRandomCoffeeImage()).thenThrow(Error()),
        verify: (cubit) {
          expect(cubit.state.runtimeType, CoffeeError);
        }
    );

    blocTest<RandomCoffeeCubit, CoffeeState>(
      'emits true when addCoffeeToFavorite is called',
      build: () => RandomCoffeeCubit(coffeeImageUseCase),
      act: (cubit) async {
        await cubit.getRandomCoffeeImage();
        await cubit.addCoffeeToFavorite();
      },
      verify: (cubit) {
        expect(cubit.state.runtimeType, LoadedCoffee);
        expect((cubit.state as LoadedCoffee).favorite, true);
      },
    );

    blocTest<RandomCoffeeCubit, CoffeeState>(
      'emits CoffeeError when addCoffeeToFavorite is called',
      build: () => RandomCoffeeCubit(coffeeImageUseCase),
      setUp: () {
        when(() => services<CoffeeImageUseCase>().addCoffeeToFavorite(fakeUri))
            .thenAnswer((_) => Future.value(false));
      },
      act: (cubit) async {
        await cubit.getRandomCoffeeImage();
        await cubit.addCoffeeToFavorite();
      },
      verify: (cubit) {
        expect(cubit.state.runtimeType, CoffeeError);
      },
    );
  });
}
