import 'package:random_coffee/data/coffee_image_datasource.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';

class CoffeeImageRepository {
  CoffeeImageRepository(this._datasource);

  late final CoffeeImageDatasource _datasource;

  Future<CoffeeImageDTO> getRandomCoffeeImage() {
    return _datasource.getRandomCoffeeImage();
  }
}
