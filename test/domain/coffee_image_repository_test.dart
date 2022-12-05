import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/data/coffee_image_datasource.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/domain/coffee_image_repository.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';

import '../test_services.dart';

void main() {
  late CoffeeImageRepository coffeeImageRepository;

  initializeServices();

  setUp(() {
    coffeeImageRepository = CoffeeImageRepository(services<CoffeeImageDatasource>());
  });
  group('CoffeeImageRepository', () {
    test('get random coffee image', () async {
      final img = await coffeeImageRepository.getRandomCoffeeImage();
      expect(img, coffeeImage);
    });
  });
}