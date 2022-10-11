part of 'album_bloc.dart';

abstract class AlbumState extends Equatable {
  const AlbumState();

  @override
  List<Object> get props => [];
}

class AlbumEmpty extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumHasData extends AlbumState {
  final List<Album> albums;

  const AlbumHasData(this.albums);

  @override
  List<Object> get props => [albums];
}

class CreateSuccess extends AlbumState {
  final String message;

  const CreateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class DeleteSuccess extends AlbumState {
  final String message;

  const DeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateSuccess extends AlbumState {
  final String message;

  const UpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}
