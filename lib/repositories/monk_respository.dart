import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/monk_api_provider.dart';

class MonkRespository {
  MonkApiProvider monkApiProvider;
  // ignore: unnecessary_null_comparison
  MonkRespository(this.monkApiProvider) : assert(monkApiProvider != null);

  Future<List<MonkModel>> fetchMonks() async {
    return await monkApiProvider.fetchMonks();
  }
}
