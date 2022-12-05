abstract class CoffeeState {}

class LoadingCoffee extends CoffeeState {}

class CoffeeError extends CoffeeState {
  CoffeeError(this.error);

  final String error;
}

class LoadedCoffee extends CoffeeState {
  LoadedCoffee({
    required this.url,
    this.favorite = false
  });

  final String url;
  final bool favorite;
}
