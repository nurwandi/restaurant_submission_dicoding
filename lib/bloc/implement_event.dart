part of 'implement_bloc.dart';

@immutable
abstract class ImplementEvent {}

class ActualiceCounter extends ImplementEvent {
  final int counter;

  ActualiceCounter(this.counter);
  
}
