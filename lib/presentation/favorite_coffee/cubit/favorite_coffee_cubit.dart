import 'package:bloc/bloc.dart';
import 'package:random_coffee/config/services.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';

final List<String> coffeeListInitialState = List.empty();

class FavoriteCoffeeCubit extends Cubit<List<String>> {

  FavoriteCoffeeCubit() : super(coffeeListInitialState);

  Future<List<String>> getFavoriteCoffeesUrls() async {
    final urls = await injector<CoffeeImageUseCase>().getFavoriteCoffees();
    emit(urls);
    return urls;
  }
}
