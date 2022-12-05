import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_coffee/presentation/favorite_coffee/cubit/favorite_coffee_cubit.dart';
import 'package:random_coffee/presentation/favorite_coffee/view/favorite_coffee_page.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';

import '../../helpers/helpers.dart';
import '../../test_services.dart';

void main() {
  initializeServices();

  group('FavoriteCoffeeView', () {
    testWidgets('renders FavoriteCoffeesView', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: FavoriteCoffeeCubit(),
          child: const FavoriteCoffeesView(),
        ),
      );
      expect(find.byType(FavoriteCoffeesView), findsOneWidget);
    });

    testWidgets('renders FavoriteCoffeeImages', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: FavoriteCoffeeCubit(),
          child: const FavoriteCoffeesView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(FavoriteCoffeeImage), findsWidgets);
    });
  });

}
