import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/data/coffee_image_datasource.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';

import '../test_services.dart';

void main() {
  initializeServices();

  group('Coffee Datasource', ()
  {
    test('get random coffee image', () async {
      final img = await CoffeeImageDatasource(services<Dio>())
          .getRandomCoffeeImage();
      expect(img, coffeeImage);
    });
  });

}