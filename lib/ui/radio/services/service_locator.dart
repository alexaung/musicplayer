import 'package:audio_service/audio_service.dart';
import 'package:thitsarparami/ui/radio/radio_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:thitsarparami/ui/radio/services/audio_handler.dart';

GetIt getIt = GetIt.instance;

Future<void> setupRadioServiceLocator() async {
  // services
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  //getIt.registerLazySingleton<PlaylistRepository>(() => DemoPlaylist());

  // page state
  getIt.registerLazySingleton<RadioManager>(() => RadioManager());
}
