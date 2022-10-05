import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_2_api/api_test.dart';
import 'package:restaurant_2_api/models/details.dart';
import 'package:restaurant_2_api/models/list.dart';

part 'implement_event.dart';
part 'implement_state.dart';

class ImplementBloc extends Bloc<ImplementEvent, ImplementState> {
  final Api api;
  ImplementBloc(this.api) : super(ImplementInitial()) {
    on<GetRestaurant>((event, emit) async {
      var restaurant = await api.list();
      emit(RestaurantLoadedState(restaurant));
    });
  }
}
