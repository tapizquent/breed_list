import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:breed_list/repository/breed_repository.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final BreedRepository repository;

  BreedBloc(this.repository);

  @override
  Stream<BreedState> transform(Stream<BreedEvent> events,
      Stream<BreedState> Function(BreedEvent event) next) {
    return super.transform(
        (events as Observable<BreedEvent>).debounceTime(
          Duration(milliseconds: 500),
        ),
        next);
  }

  @override
  BreedState get initialState => BreedUninitialized();

  @override
  Stream<BreedState> mapEventToState(
    BreedEvent event,
  ) async* {
    if (event is FetchBreedEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is BreedUninitialized) {
          final breeds = await repository.getBreeds(0, 20);
          yield BreedLoaded(breeds: breeds, hasReachedMax: false);
        }
        if (currentState is BreedLoaded) {
          final currentPage =
              ((currentState as BreedLoaded).breeds.length ~/ 20);
          final breeds = await repository.getBreeds(currentPage, 20);
          yield breeds.isEmpty
              ? (currentState as BreedLoaded).copyWith(hasReachedMax: true)
              : BreedLoaded(
                  breeds: (currentState as BreedLoaded).breeds + breeds,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield BreedError();
      }
    }
  }

  bool _hasReachedMax(BreedState state) =>
      state is BreedLoaded && state.hasReachedMax;
}
