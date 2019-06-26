import 'package:breed_list/model/breed.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BreedState extends Equatable {
  BreedState([List props = const []]) : super(props);
}

class BreedUninitialized extends BreedState {
  @override
  String toString() => 'BreedUninitialized';
}

class BreedError extends BreedState {
  @override
  String toString() => 'BreedError';
}

class BreedLoaded extends BreedState {
  final List<Breed> breeds;
  final bool hasReachedMax;

  BreedLoaded({
    this.breeds,
    this.hasReachedMax,
  }) : super([breeds, hasReachedMax]);

  BreedLoaded copyWith({
    List<Breed> breeds,
    bool hasReachedMax,
  }) {
    return BreedLoaded(
        breeds: breeds ?? this.breeds,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() =>
      'BreedLoaded { breeds: ${breeds.length}, hasReachedMax: $hasReachedMax}';
}
