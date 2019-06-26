import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BreedEvent extends Equatable {
  BreedEvent([List props = const []]) : super(props);
}

class FetchBreedEvent extends BreedEvent {
  @override
  String toString() => 'Fetch';
}
