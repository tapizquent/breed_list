import 'package:equatable/equatable.dart';

class Breed extends Equatable {
  final int id;
  final String name;
  final String bredFor;
  final String temperament;
  final String group;

  Breed({this.id, this.name, this.bredFor, this.temperament, this.group})
      : super([id, name, bredFor, temperament, group]);

  @override
  String toString() => 'Breed {id: $id}';
}
