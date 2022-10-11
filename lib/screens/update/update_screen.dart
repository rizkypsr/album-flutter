import 'dart:io';

import 'package:album_app/models/album.dart';
import 'package:album_app/screens/bloc/album_bloc.dart';
import 'package:album_app/screens/create/custom_text_field.dart';
import 'package:album_app/util/colors.dart';
import 'package:album_app/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.album});

  final Album album;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController grupController;
  late TextEditingController albumController;
  late TextEditingController priceController;

  final ImagePicker _picker = ImagePicker();

  XFile? image;
  File? imageFile;

  @override
  void initState() {
    super.initState();
    grupController = TextEditingController(text: widget.album.grupName);
    albumController = TextEditingController(text: widget.album.albumName);
    priceController =
        TextEditingController(text: widget.album.price.toString());
  }

  _pickFromGallery() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: grayColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ubah Album',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: grupController,
                        maxLength: 15,
                        hint: 'Nama Grup',
                        errorText: 'Pastikan nama grup terisi',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        controller: albumController,
                        maxLength: 50,
                        hint: 'Nama Album',
                        errorText: 'Pastikan nama album terisi',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        controller: priceController,
                        hint: 'Harga',
                        errorText: 'Pastikan harga terisi',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      GestureDetector(
                        onTap: () => _pickFromGallery(),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: const Border.fromBorderSide(BorderSide(
                                color: Colors.grey,
                              ))),
                          child: image != null
                              ? Center(
                                  child: Text(
                                    image!.name,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Center(
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.center,
                                    spacing: 12,
                                    children: const [
                                      Icon(Icons.edit),
                                      Text('Ubah Gambar'),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: grayColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final album = Album(
                                id: widget.album.id,
                                grupName: grupController.text,
                                albumName: albumController.text,
                                price: int.parse(priceController.text),
                                imagePath: image != null
                                    ? Utility.base64String(
                                        imageFile!.readAsBytesSync(),
                                      )
                                    : widget.album.imagePath,
                              );
                              BlocProvider.of<AlbumBloc>(context)
                                  .add(UpdateAlbum(album));

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Simpan'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
