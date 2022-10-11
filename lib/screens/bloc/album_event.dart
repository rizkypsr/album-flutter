part of 'album_bloc.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class GetAlbumList extends AlbumEvent {}

class CreateAlbum extends AlbumEvent {
  final Album album;

  const CreateAlbum(this.album);

  @override
  List<Object> get props => [album];
}

class UpdateAlbum extends AlbumEvent {
  final Album album;

  const UpdateAlbum(this.album);

  @override
  List<Object> get props => [album];
}

class DeleteAlbum extends AlbumEvent {
  final int albumId;

  const DeleteAlbum(this.albumId);

  @override
  List<Object> get props => [albumId];
}
