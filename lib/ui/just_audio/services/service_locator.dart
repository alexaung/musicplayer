import 'package:audio_service/audio_service.dart';
import 'package:thitsarparami/repositories/repositories.dart';
import 'package:thitsarparami/services/services.dart';

import '../player_manager.dart';
import 'audio_handler.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  //getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());
  getIt.registerLazySingleton<SongRespository>(() => SongRespository(SongApiProvider()));

  // page state
  getIt.registerLazySingleton<PlayerManager>(() => PlayerManager());
}
