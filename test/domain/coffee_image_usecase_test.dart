import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/domain/coffee_image_repository.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';

import '../test_services.dart';

void main() {
  late CoffeeImageUseCase coffeeImageUseCase;

  initializeServices();

  setUp(() {
    coffeeImageUseCase = CoffeeImageUseCase(
        services<CoffeeImageRepository>(), services<FileManager>());
  });

  group('CoffeeImageUsecases', () {
    test('get random coffee image', () async {
      final img = await coffeeImageUseCase.getRandomCoffeeImage();
      expect(img, coffeeImage);
    });

    test('favorite current image', () async {
      final result = await coffeeImageUseCase.addCoffeeToFavorite(fakeUri);
      expect(result, true);
    });

    test('get favorites', () async {
      final result = await coffeeImageUseCase.getFavoriteCoffees();
      expect(result, fakeFavorites);
    });
  });
}