import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class MonkRespository {
  MonkApiProvider monkApiProvider;
  // ignore: unnecessary_null_comparison
  MonkRespository(this.monkApiProvider) : assert(monkApiProvider != null);

  Future<List<Monk>> fetchMonks() async {
    return await monkApiProvider.fetchMonks();
  }

  Future<List<Monk>> searchMonks(String query) async {
    return await monkApiProvider.searchMonks(query);
  }
}
