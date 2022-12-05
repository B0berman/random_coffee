import 'package:bloc/bloc.dart';
import 'package:random_coffee/domain/coffee_image_use_case.dart';
import 'package:random_coffee/presentation/shared/list_state.dart';

const ListState<String> coffeeListInitialState = ListState.loading();

class FavoriteCoffeeCubit extends Cubit<ListState<String>> {

  FavoriteCoffeeCubit(this._coffeeImageUseCase) : super(coffeeListInitialState);

  final CoffeeImageUseCase _coffeeImageUseCase;

  Future<void> getFavoriteCoffeesUrls() async {
    final urls = await _coffeeImageUseCase.getFavoriteCoffees();
    emit(ListState.success(items: urls));
  }
}
