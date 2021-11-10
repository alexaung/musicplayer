import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thitsarparami/db/models/models.dart';
import 'package:thitsarparami/db/reposiotries/repositories.dart';

part 'favourite_list_event.dart';
part 'favourite_list_state.dart';

class FavouriteListBloc extends Bloc<FavouriteListEvent, FavouriteListState> {
  final FavouriteRepository favouriteRespository;
  late List<Favourite> favourites;

  FavouriteListBloc({required this.favouriteRespository}) : super(FavouriteListInitial());

  @override
  Stream<FavouriteListState> mapEventToState(FavouriteListEvent event) async* {
    if (event is GetFavourites) {
      yield FavouriteListLoading();
      try {
        final List<Favourite> favouriteLists = await favouriteRespository.getAllFavourites();
        yield FavouriteListLoaded(favourites: favouriteLists);
      } catch (e) {
        yield FavouriteListError(error: (e.toString()));
      }
    }
  }
}
