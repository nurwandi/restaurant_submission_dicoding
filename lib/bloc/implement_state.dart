part of 'implement_bloc.dart';

@immutable
abstract class ImplementState {}

class ImplementInitial extends ImplementState {}

class ActualicedState extends ImplementState {
  final int counter;

  ActualicedState(this.counter);
}
