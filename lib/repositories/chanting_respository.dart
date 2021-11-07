
import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class ChantingRespository {
  ChantingApiProvider chantingApiProvider;
  // ignore: unnecessary_null_comparison
  ChantingRespository(this.chantingApiProvider) : assert(chantingApiProvider != null);

  Future<List<Chanting>> fetchChantings() async {
    return await chantingApiProvider.fetchChantings();
  }
}