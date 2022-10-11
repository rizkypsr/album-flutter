import 'dart:io';

import 'package:album_app/models/album.dart';
import 'package:album_app/screens/bloc/album_bloc.dart';
import 'package:album_app/screens/create/custom_text_field.dart';
import 'package:album_app/util/colors.dart';
import 'package:album_app/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController grupController = TextEditingController();
  final TextEditingController albumController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  XFile? image;
  File? imageFile;

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
              'Tambah Album',
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
                                    children: const [
                                      Icon(Icons.add),
                                      Text('Tambah Gambar'),
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
                                grupName: grupController.text,
                                albumName: albumController.text,
                                price: int.parse(priceController.text),
                                imagePath: Utility.base64String(
                                  imageFile!.readAsBytesSync(),
                                ),
                              );
                              BlocProvider.of<AlbumBloc>(context)
                                  .add(CreateAlbum(album));

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
