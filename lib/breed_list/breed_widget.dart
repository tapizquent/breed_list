import 'package:breed_list/model/breed.dart';
import 'package:flutter/material.dart';

class BreedWidget extends StatelessWidget {
  final Breed breed;

  const BreedWidget({Key key, @required this.breed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(16.0),
      leading: Text(
        "${breed.id}",
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(breed.name),
      isThreeLine: true,
      subtitle: Text(breed.temperament),
      dense: true,
      trailing: Text(
        breed.group,
        style: TextStyle(fontSize: 10.0),
      ),
    );
  }
}
