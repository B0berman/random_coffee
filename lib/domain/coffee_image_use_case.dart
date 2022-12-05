import 'package:random_coffee/data/coffee_image_dto.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/domain/coffee_image_repository.dart';

class CoffeeImageUseCase {
  CoffeeImageUseCase(this._repository, this._fileManager);

  late final CoffeeImageRepository _repository;
  late final FileManager _fileManager;

  Future<CoffeeImageDTO> getRandomCoffeeImage() {
    return _repository.getRandomCoffeeImage();
  }

  Future<bool> addCoffeeToFavorite(String url) {
    return _fileManager.downloadAndWriteImageFile(url);
  }

  Future<List<String>> getFavoriteCoffees() {
    return _fileManager.readDirectory();
  }
 }
