import 'package:random_coffee/data/definitions.dart';

class CoffeeImageDTO {
  const CoffeeImageDTO({required this.file});

  factory CoffeeImageDTO.fromJson(JSON json) {
    return CoffeeImageDTO(file: json['file'] as String);
  }

  final String file;
}