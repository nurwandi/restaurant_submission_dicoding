import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'implement_event.dart';
part 'implement_state.dart';

class ImplementBloc extends Bloc<ImplementEvent, ImplementState> {
  ImplementBloc() : super(ImplementInitial()) {
    on<ActualiceCounter>((event, emit) {
      emit(ActualicedState(event.counter + 1));
    });
  }
}
