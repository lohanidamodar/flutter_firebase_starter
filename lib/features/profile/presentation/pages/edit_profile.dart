import 'dart:io';

import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebasestarter/core/data/res/data_constants.dart';
import 'package:firebasestarter/features/profile/data/model/user.dart';
import 'package:firebasestarter/features/profile/data/model/user_field.dart';
import 'package:firebasestarter/features/profile/data/service/user_db_service.dart';
import 'package:firebasestarter/features/profile/presentation/widgets/avatar.dart';
import 'package:firebasestarter/generated/l10n.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({Key key, this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController _nameController;
  bool _processing;
  AppState state;
  File _image;
  String _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    _processing = false;
    state = AppState.free;
    _nameController = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).editProfile),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Center(
            child: Avatar(
              showButton: true,
              onButtonPressed: _pickImageButtonPressed,
              radius: 50,
              image: state == AppState.cropped && _image != null
                  ? FileImage(_image)
                  : widget.user.photoUrl != null
                      ? NetworkImage(widget.user.photoUrl)
                      : null,
            ),
          ),
          const SizedBox(height: 10.0),
          Center(child: Text(widget.user.email)),
          const SizedBox(height: 10.0),
          TextField(
            controller: _nameController,
            decoration:
                InputDecoration(labelText: S.of(context).nameFieldLabel),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: RaisedButton(
              child: _processing
                  ? CircularProgressIndicator()
                  : Text(S.of(context).saveButtonLabel),
              onPressed: _processing
                  ? null
                  : () async {
                      //save name
                      if (_nameController.text.isEmpty &&
                          (_image == null || state != AppState.cropped)) return;
                      setState(() {
                        _processing = true;
                      });
                      if (_image != null && state == AppState.cropped) {
                        await uploadImage();
                      }
                      Map<String, dynamic> data = {};
                      if (_nameController.text.isNotEmpty)
                        data[UserFields.name] = _nameController.text;
                      if (_uploadedFileURL != null)
                        data[UserFields.photoUrl] = _uploadedFileURL;
                      if (data.isNotEmpty) {
                        await userDBS.updateData(widget.user.id, data);
                      }
                      if (mounted) {
                        setState(() {
                          _processing = false;
                        });
                        Navigator.pop(context);
                      }
                    },
            ),
          )
        ],
      ),
    );
  }

  void _pickImageButtonPressed() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              S.of(context).pickImageDialogTitle,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...ListTile.divideTiles(color: Theme.of(context).dividerColor,tiles: [

                    ListTile(
                      onTap: () {
                        getImage(ImageSource.camera);
                      },
                      title: Text(S.of(context).pickFromCameraButtonLabel),
                    ),
                    ListTile(
                      onTap: () {
                        getImage(ImageSource.gallery);
                      },
                      title: Text(S.of(context).pickFromGalleryButtonLabel),
                    ),
                ],),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).cancelButtonLabel,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(
        source: source);
    if(image == null) return;
    setState(() {
      _image = image;
      _cropImage();
      Navigator.pop(context);
    });
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      maxWidth: 800,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  Future uploadImage() async {
    String path =
        '${AppDBConstants.usersStorageBucket}/${widget.user.id}/${Path.basename(_image.path)}';
    String url = await StorageService.instance.uploadFile(path, _image);
    setState(() {
      _uploadedFileURL = url;
    });
  }
}
