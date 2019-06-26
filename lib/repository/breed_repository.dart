import 'package:breed_list/data_provider/data_provider.dart';
import 'package:breed_list/model/breed.dart';

class BreedRepository {
  final DataProvider _breedProvider;

  BreedRepository(this._breedProvider);

  Future<List<Breed>> getBreeds(int page, int limit) async {
    final breedsList = await _breedProvider.readData(page, limit);
    return breedsList.map((rawBreed) {
      return Breed(
          id: rawBreed["id"],
          name: rawBreed["name"],
          bredFor: rawBreed["bred_for"] ?? "Not available",
          temperament: rawBreed["temperament"] ?? "Not available",
          group: rawBreed["breed_group"] ?? "Not available");
    }).toList();
  }
}
