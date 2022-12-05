import 'package:dio/dio.dart';
import 'package:random_coffee/config/constants.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';
import 'package:random_coffee/data/definitions.dart';

class CoffeeImageDatasource {

  CoffeeImageDatasource(this._dio);

  late final Dio _dio;

  Future<CoffeeImageDTO> getRandomCoffeeImage() async {
    final r = await _dio.get<JSON>(coffeeUrl);

    if (r.statusCode != 200) {
      throw Error();
    }
    return CoffeeImageDTO.fromJson(r.data!);
  }
}