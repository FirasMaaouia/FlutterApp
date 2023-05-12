import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/static.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/screens/profile/profile_screen.dart';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File("/" + pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  upload(File imageFile) async {
    // open a bytestream

    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("${MyUrls.serverUrl}/updateImg");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('myFile', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['lol'] = Userutils.email;
    request.fields['email'] = Userutils.email;
    Userutils.profilepic = Userutils.email + ".png";
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  bool isloaded = false;
  var result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update your profile picture"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                "Change your profile picture",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 25.3,
                    letterSpacing: 0.27,
                    color: AppThemeColors.darkBlue),
              ),
              SizedBox(height: 15),
              Text(
                "Choose a picture from gallery then click on upload",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.3,
                    letterSpacing: 0.27,
                    color: AppThemeColors.pureBlack),
              ),
              SizedBox(height: 35),
              _firstWidget(),
              SizedBox(height: 15),
              InkWell(
                  onTap: () {
                    if (_image == null) {
                      ToastUtils.showCustomToast(
                          context, "Please Select a Picture");
                    } else {
                      upload(_image);
                      ToastUtils.showCustomToast(
                          context, "Image successfully added!");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    }
                  },
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: myBoxDecoration(),
                              height: 55,
                              width: 30,
                              child: Icon(
                                Icons.upload_rounded,
                                color: Colors.white,
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Upload & Finish',
                                  style: TextStyle(
                                    fontSize: 23,
                                  ),
                                ))),
                      ],
                    ),
                  )),
            ],
          )),
    );
  }

  Widget _firstWidget() {
    return InkWell(
        onTap: () async => await getImage(),
        child: Card(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 55,
                    width: 30,
                    decoration: myBoxDecoration(),
                    child: Icon(
                      Icons.upload_file,
                      color: Colors.white,
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Browse Picture',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ))),
            ],
          ),
        ));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //         <--- border radius here
          ),
    );
  }
}
