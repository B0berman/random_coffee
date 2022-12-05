import 'package:flutter_test/flutter_test.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';

import '../test_services.dart';

void main() {
  final json = {'file': fakeUri};
  group('CoffeeImageDTO', () {
    test('Deserialize JSON correctly', () {
      final dto = CoffeeImageDTO.fromJson(json);
      expect(dto.file, fakeUri);
      expect(dto.file, dto.props.first);
    });
  });
}