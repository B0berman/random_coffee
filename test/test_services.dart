import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_coffee/config/constants.dart';
import 'package:random_coffee/data/coffee_image_datasource.dart';
import 'package:random_coffee/data/coffee_image_dto.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/domain/coffee_image_repository.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/random_coffee/cubit/random_coffee_state.dart';
import 'package:random_coffee/presentation/random_coffee/random_coffee.dart';

final services = GetIt.instance;

const fakeUri = 'http://fake-image.jpg';
const fakeFavorites = ['favoriteA', 'favoriteB'];
const coffeeImage = CoffeeImageDTO(file: fakeUri);

class MockCoffeeImageUseCase extends Mock implements CoffeeImageUseCase {}
class MockCoffeeImageDatasource extends Mock implements CoffeeImageDatasource {}
class MockRandomCoffeeCubit extends MockCubit<CoffeeState> implements RandomCoffeeCubit {}
class MockFileManager extends Mock implements FileManager {}
class MockCoffeeImageRepository extends Mock implements CoffeeImageRepository {}
class MockDio extends Mock implements Dio {}

Future<void> initializeServices() async {
  // Dio client
  final dio = Dio(BaseOptions(baseUrl: coffeeUrl));
  final dioAdapter = DioAdapter(dio: dio);

  dio.httpClientAdapter = dioAdapter;
  dioAdapter..onGet(
    coffeeUrl,
        (request) => request.reply(200, {'file': fakeUri},
            headers: {Headers.contentTypeHeader: [Headers.jsonContentType]}),
  )
  ..onGet(
    fakeUri,
        (request) => request.reply(200, Uint8List.fromList([5, 5, 5, 5])),
  );

  services..registerSingleton<Dio>(dio)
    ..registerSingleton<CoffeeImageRepository>(MockCoffeeImageRepository())
    ..registerSingleton<FileManager>(MockFileManager())
    ..registerSingleton<CoffeeImageUseCase>(MockCoffeeImageUseCase())
    ..registerSingleton<CoffeeImageDatasource>(MockCoffeeImageDatasource());

  // Mock default return values
  when(services<CoffeeImageRepository>().getRandomCoffeeImage).thenAnswer((_) => Future.value(coffeeImage));
  when(services<CoffeeImageUseCase>().getRandomCoffeeImage).thenAnswer((_) => Future.value(coffeeImage));
  when(services<CoffeeImageUseCase>().getFavoriteCoffees).thenAnswer((_) => Future.value(fakeFavorites));
  when(services<CoffeeImageDatasource>().getRandomCoffeeImage).thenAnswer((_) => Future.value(coffeeImage));
  when(() => services<CoffeeImageUseCase>().addCoffeeToFavorite(fakeUri)).thenAnswer((_) => Future.value(true));
  when(() => services<FileManager>().downloadAndWriteImageFile(fakeUri)).thenAnswer((_) => Future.value(true));
  when(() => services<FileManager>().readDirectory()).thenAnswer((_) => Future.value(fakeFavorites));
}
