import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:esprit/screens/courses/coursesRoute.dart';
import 'package:esprit/screens/courses/laststep.dart';
import 'package:esprit/src/utils/my_urls.dart';
import 'package:esprit/static.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CourseUpload extends StatefulWidget {
  @override
  _CourseUploadState createState() => _CourseUploadState();
}

class _CourseUploadState extends State<CourseUpload> {
  File _image;
  final picker = ImagePicker();
  String name;

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

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  upload(File imageFile) async {
    // open a bytestream
    name = generateRandomString(15);
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("${MyUrls.serverUrl}/updateCourseImg");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('myFile', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);
    request.fields['lol'] = name;
    request.fields['title'] = CourseUtils.title;

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
        title: Text("Final Step"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CoursesScreen()));
            },
            child: Text('Skip'),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                "Give your course a picture!",
                style: TextStyle(
                    fontFamily: "muli",
                    fontWeight: FontWeight.bold,
                    fontSize: 25.3,
                    letterSpacing: 0.27,
                    color: AppThemeColors.darkBlue),
              ),
              SizedBox(height: 15),
              Text(
                "Hint: by default your profile picture will be used as a course display image.",
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
                              builder: (context) => CoursesScreen()));
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
