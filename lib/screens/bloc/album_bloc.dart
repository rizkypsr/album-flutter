import 'package:album_app/helper/db_helper.dart';
import 'package:album_app/models/album.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumEmpty()) {
    on<GetAlbumList>((event, emit) async {
      final DBHelper dbHelper = DBHelper();

      emit(AlbumLoading());
      final results = await dbHelper.getAlbums();

      if (results.isEmpty) {
        emit(AlbumEmpty());
      } else {
        emit(AlbumHasData(results));
      }
    });

    on<CreateAlbum>((event, emit) async {
      final album = event.album;
      final DBHelper dbHelper = DBHelper();

      emit(AlbumLoading());
      final result = await dbHelper.insertAlbum(album);
      final results = await dbHelper.getAlbums();

      emit(CreateSuccess(result));
      emit(AlbumHasData(results));
    });

    on<DeleteAlbum>((event, emit) async {
      final albumId = event.albumId;
      final DBHelper dbHelper = DBHelper();

      emit(AlbumLoading());
      final result = await dbHelper.deleteAlbum(albumId);
      final results = await dbHelper.getAlbums();

      emit(DeleteSuccess(result));
      emit(AlbumHasData(results));
    });

    on<UpdateAlbum>((event, emit) async {
      final album = event.album;
      final DBHelper dbHelper = DBHelper();

      emit(AlbumLoading());
      final result = await dbHelper.updateAlbum(album);
      final results = await dbHelper.getAlbums();

      emit(UpdateSuccess(result));
      emit(AlbumHasData(results));
    });
  }
}
