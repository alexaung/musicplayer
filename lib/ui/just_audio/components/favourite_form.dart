import 'package:audio_service/audio_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thitsarparami/db/blocs/blocs.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/helper/constants.dart';
import 'package:thitsarparami/helper/enum.dart';
import 'package:thitsarparami/ui/just_audio/services/player_manager.dart';
import 'package:thitsarparami/ui/just_audio/services/service_locator.dart';

class FavouriteForm extends StatefulWidget {
  final SocialMode socialMode;

  const FavouriteForm({Key? key, required this.socialMode}) : super(key: key);

  @override
  State<FavouriteForm> createState() => _FavouriteFormState();
}

class _FavouriteFormState extends State<FavouriteForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  final List<String?> errors = [];
  Favourite favourite = Favourite();
  final nameControler = TextEditingController();
  bool isSubmitButtonActive = true;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  void create(SocialMode socialMode) {
    final playerManager = getIt<PlayerManager>();
    MediaItem currentSong = playerManager.currentMediaItem;
    FavouriteSong song = FavouriteSong(
      id: int.parse(currentSong.id),
      favouriteId: null,
      album: currentSong.album!,
      title: currentSong.title,
      artist: currentSong.artist!,
      artUrl: currentSong.artUri.toString(),
      audioUrl: currentSong.extras!['url'],
      isFavourite: socialMode == SocialMode.favourite ? true : false,
      isDownloaded: socialMode == SocialMode.download ? true : false,
    );
    if (socialMode == SocialMode.favourite) {
      playerManager.setRating(true);

      BlocProvider.of<FavouriteBloc>(context).add(
        CreateFavourite(
          favourite: Favourite(id: null, name: nameControler.text, song: song),
        ),
      );
      Navigator.pop(context);
    } else {
      BlocProvider.of<FavouriteBloc>(context).add(
        CreateDownload(
          favourite: Favourite(id: null, name: nameControler.text, song: song),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteError) {
          isSubmitButtonActive = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: AutoSizeText(state.error),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: '?????????????????????',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        } else if (state is Processing) {
          setState(() {
            isSubmitButtonActive = false;
          });
        } else if (state is CreateFavouriteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AutoSizeText(state.successMessage),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: '?????????????????????',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
          Navigator.of(context).pop();
        } else if (state is CreateDownloadSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: _favouriteForm(widget.socialMode),
    );
  }

  Widget _favouriteForm(SocialMode socialMode) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _nameField(),
            const SizedBox(
              height: 10,
            ),
            _submitBotton(socialMode),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<FavouriteBloc, FavouriteState>(
      builder: (context, state) {
        return TextFormField(
          //onSaved: (newValue) => name = newValue,
          controller: nameControler,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kFavouriteNameNullError);
            }
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kFavouriteNameNullError);
              return "";
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular((15 / 375.0) * screenWidth),
            ),
            labelText: "Name",
            hintText: "Enter playlist name",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.favorite_outline),
          ),
        );
      },
    );
  }

  Widget _submitBotton(SocialMode socialMode) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10.0),
        //onPrimary: Theme.of(context).primaryColor,
        onSurface: Theme.of(context).primaryColorLight,
      ),
      onPressed: isSubmitButtonActive
          ? () {
              create(socialMode);
            }
          : null,
      icon: isSubmitButtonActive
          ? const Icon(Icons.save_outlined)
          : loadingIcon(),
      label: const AutoSizeText('Create Playlist'),
    );
  }

  Container loadingIcon() {
    return Container(
      width: 24,
      height: 24,
      padding: const EdgeInsets.all(2.0),
      child: const CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3,
      ),
    );
  }
}
