import 'package:album_app/models/album.dart';
import 'package:album_app/screens/bloc/album_bloc.dart';
import 'package:album_app/screens/create/create_screen.dart';
import 'package:album_app/screens/update/update_screen.dart';
import 'package:album_app/util/colors.dart';
import 'package:album_app/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AlbumBloc>(context).add(GetAlbumList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateScreen(),
              ));
        },
        backgroundColor: Colors.white,
        foregroundColor: grayColor,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 64,
              ),
              const Text(
                'K-POP Album',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: BlocConsumer<AlbumBloc, AlbumState>(
                  listener: (context, state) {
                    if (state is CreateSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AlbumLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AlbumHasData) {
                      final result = state.albums;

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 9 / 17,
                        ),
                        itemCount: result.length,
                        itemBuilder: (context, index) => AlbumItem(
                          album: result[index],
                        ),
                      );
                    }

                    return const Center(
                      child: Text('Tidak Ada Album'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AlbumItem extends StatelessWidget {
  const AlbumItem({super.key, required this.album});

  final Album album;

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
      menuOffset: 10,
      animateMenuItems: true,
      openWithTap: true,
      menuItems: [
        FocusedMenuItem(
          title: const Text("Ubah"),
          trailingIcon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateScreen(album: album),
              ),
            );
          },
        ),
        FocusedMenuItem(
            title: const Text(
              "Delete",
              style: TextStyle(color: Colors.redAccent),
            ),
            trailingIcon: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              BlocProvider.of<AlbumBloc>(context).add(DeleteAlbum(album.id!));
            }),
      ],
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          Utility.imageFromBase64String(album.imagePath).image,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: grayColor,
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      album.grupName!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              album.albumName!,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Rp. ${album.price!}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
