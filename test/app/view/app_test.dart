// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/app/app.dart';
import 'package:random_coffee/presentation/favorite_coffee/view/favorite_coffee_page.dart';
import 'package:random_coffee/presentation/random_coffee/random_coffee.dart';

import '../../test_services.dart';

void main() {
  initializeServices();
  setUpAll(() => HttpOverrides.global = null);

  group('App', () {
    testWidgets('renders RandomCoffeePage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(RandomCoffeePage), findsOneWidget);
    });

    testWidgets('renders FavoriteCoffeePage', (tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();
      expect(find.byType(FavoriteCoffeePage), findsOneWidget);
    });
  });
}
