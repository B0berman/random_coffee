import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/random_coffee/random_coffee.dart';

import '../../helpers/helpers.dart';
import '../../test_services.dart';

void main() {

  initializeServices();

  group('RandomCoffeeView', () {
    testWidgets('renders RandomCoffeeView', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: RandomCoffeeCubit(services<CoffeeImageUseCase>()),
          child: const RandomCoffeeView(),
        ),
      );
      expect(find.byType(RandomCoffeeView), findsOneWidget);
    });

    testWidgets('calls getRandomCoffeeImage when refresh button is tapped',
        (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: RandomCoffeeCubit(services<CoffeeImageUseCase>()),
          child: const RandomCoffeeView(),
        ),
      );
      await tester.tap(find.byIcon(Icons.refresh));
      verify(services<CoffeeImageUseCase>().getRandomCoffeeImage).called(1);
    });

    testWidgets('calls addCoffeeToFavorite when favorite button is tapped',
            (tester) async {
          await tester.pumpApp(
            BlocProvider.value(
              value: RandomCoffeeCubit(services<CoffeeImageUseCase>()),
              child: const RandomCoffeeView(),
            ),
          );
          await tester.tap(find.byIcon(Icons.refresh));
          await tester.tap(find.byIcon(Icons.favorite_border_outlined));
          verify(() => services<CoffeeImageUseCase>().addCoffeeToFavorite(fakeUri)).called(1);
        });
  });
}
