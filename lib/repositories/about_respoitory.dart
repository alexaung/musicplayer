import 'package:thitsarparami/models/models.dart';
import 'package:thitsarparami/services/services.dart';

class AboutRespository {
  AboutApiProvider aboutApiProvider;
  // ignore: unnecessary_null_comparison
  AboutRespository(this.aboutApiProvider) : assert(AboutApiProvider != null);

  Future<About> fetchAbout() async {
    return await aboutApiProvider.fetchAbout();
  }
}