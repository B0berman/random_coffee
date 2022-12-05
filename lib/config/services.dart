import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:random_coffee/data/coffee_image_datasource.dart';
import 'package:random_coffee/data/file_manager.dart';
import 'package:random_coffee/domain/coffee_image_repository.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies(Dio dio) async {
  // Dio client
  injector..registerSingleton<Dio>(dio)
    ..registerSingleton<CoffeeImageDatasource>(CoffeeImageDatasource(dio))
    ..registerSingleton<FileManager>(FileManager(dio))
    ..registerSingleton<CoffeeImageRepository>(
        CoffeeImageRepository(injector<CoffeeImageDatasource>()))
    ..registerSingleton<CoffeeImageUseCase>(
        CoffeeImageUseCase(injector<CoffeeImageRepository>(),
            injector<FileManager>()),);
}
