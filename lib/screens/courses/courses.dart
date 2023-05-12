import 'package:esprit/screens/courses/addnewcoursescreen.dart';
import 'package:esprit/screens/courses/courseService.dart';
import 'package:esprit/screens/courses/coursesModel.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:esprit/CalendarAPI/dashboard_screen.dart';
import 'package:esprit/CalendarAPI/secrets.dart';
import 'package:esprit/CalendarAPI/utils/calendar_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis/calendar/v3.dart' as cal;
import 'package:esprit/src/utils/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:esprit/Home/AppTheme/appthemeColors.dart';
import 'package:animations/animations.dart';
import 'package:esprit/screens/courses/userCoursesUI.dart';
import 'package:esprit/screens/courses/UserInfoCourse.dart';

class Coursespage extends StatefulWidget {
  @override
  CoursespageState createState() {
    return CoursespageState();
  }
}

class CoursespageState extends State<Coursespage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  // ignore: unused_field
  List<CourseList> _courses;
  List<CourseList> _usercourses;
  List<CourseList> filteredUsers = List();
  int length;
  bool _loading;
  String courseid;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _loading = true;
    Services.getCourses().then((courses) {
      setState(() {
        _courses = courses;
        _loading = false;
      });
    });
    Services.getuserCourses().then((courses) {
      setState(() {
        _usercourses = courses;
        filteredUsers = _usercourses;

        _loading = false;
      });
    });
    super.initState();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    Services.getuserCourses().then((courses) {
      setState(() {
        _usercourses = courses;
        filteredUsers = _usercourses;

        _loading = false;
      });
    });
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<http.Response> deleteCourse() async {
    var url = '${MyUrls.serverUrl}/coursedelete/$courseid';
    var response = await http.get(url);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    if (filteredUsers.length == 0) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              _loading ? 'Loading...' : 'My Courses',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          //Init Floating Action Bubble
          body: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              color: Colors.white,
              backgroundColor: Colors.blue,
              child: Center(
                child: Text('No courses found !'),
              )),
          floatingActionButton: FloatingActionBubble(
            // Menu items
            items: <Bubble>[
              Bubble(
                title: "Add new course!",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.screen_share_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateNewCourseScreen()),
                  );
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title: "Schedule an Event",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.people_alt_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () async {
                  await Firebase.initializeApp();
                  var _clientID = new ClientId(Secret.ANDROID_CLIENT_ID, "");
                  const _scopes = const [cal.CalendarApi.CalendarScope];
                  await clientViaUserConsent(_clientID, _scopes, prompt)
                      .then((AuthClient client) async {
                    CalendarClient.calendar = cal.CalendarApi(client);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
              ),
              //Floating action menu item
              Bubble(
                title: "Close",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.close_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.blue,

            // Flaoting Action button Icon
            iconData: Icons.ac_unit,
            backGroundColor: Colors.white,
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              _loading ? 'Loading...' : 'My Courses',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          //Init Floating Action Bubble
          body: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              color: Colors.white,
              backgroundColor: Colors.blue,
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Filter by Title or Description',
                  ),
                  onChanged: (string) {
                    setState(() {
                      filteredUsers = _usercourses
                          .where((u) => (u.title
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u.description
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    });
                  },
                ),
                SizedBox(height: 30),
                Container(
                  child: Expanded(
                    child: GridView(
                      padding: const EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      children: List<Widget>.generate(filteredUsers.length,
                          (int index) {
                        CourseList course = filteredUsers[index];
                        String id = course.id;
                        String title = course.title;
                        String category = course.category;
                        String name = course.fullname;
                        String usermail = course.usermail;
                        String description = course.description;
                        String date = course.date;
                        String available = course.available;
                        String bprice = course.basicprice;
                        String bdesc = course.basicdescription;
                        String bhours = course.basichours;
                        String sprice = course.standardprice;
                        String sdesc = course.standarddesc;
                        String shours = course.standardhours;
                        String pprice = course.premiumprice;
                        String pdesc = course.premiumdesc;
                        String phours = course.premiumhours;
                        double rating = course.ratingAvg;
                        String imagePath = course.imagepath;

                        return Padding(
                          padding: const EdgeInsets.only(left: 18, right: 18),
                          child: OpenContainer(
                            openColor:
                                AppThemeColors.darkBlue.withOpacity(0.15),
                            closedShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            transitionType: ContainerTransitionType.fade,
                            transitionDuration: Duration(milliseconds: 800),
                            closedColor: AppThemeColors.bgColor,
                            closedElevation: 0.0,
                            openElevation: 0.0,
                            openBuilder: (context, _) {
                              return UserInfoCourse(
                                  id: id,
                                  title: title,
                                  category: category,
                                  rating: rating,
                                  imagePath: imagePath,
                                  name: name,
                                  usermail: usermail,
                                  description: description,
                                  date: date,
                                  available: available,
                                  bprice: bprice,
                                  bdesc: bdesc,
                                  bhours: bhours,
                                  sprice: sprice,
                                  sdesc: sdesc,
                                  shours: shours,
                                  pprice: pprice,
                                  pdesc: pdesc,
                                  phours: phours);
                            },
                            closedBuilder: (context, callBack) {
                              return UserCoursesUI(
                                courses: filteredUsers[index],
                                onTab: callBack,
                              );
                            },
                          ),
                        );
                      }),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 0.7,
                      ),
                    ),
                  ),
                ),
              ])),
          floatingActionButton: FloatingActionBubble(
            // Menu items
            items: <Bubble>[
              Bubble(
                title: "Add new course!",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.screen_share_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateNewCourseScreen()),
                  );
                  _animationController.reverse();
                },
              ),
              // Floating action menu item
              Bubble(
                title: "Schedule an Event",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.people_alt_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () async {
                  await Firebase.initializeApp();
                  var _clientID = new ClientId(Secret.ANDROID_CLIENT_ID, "");
                  const _scopes = const [cal.CalendarApi.CalendarScope];
                  await clientViaUserConsent(_clientID, _scopes, prompt)
                      .then((AuthClient client) async {
                    CalendarClient.calendar = cal.CalendarApi(client);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
              ),
              //Floating action menu item
              Bubble(
                title: "Close",
                iconColor: Colors.white,
                bubbleColor: Colors.blue,
                icon: Icons.close_rounded,
                titleStyle: TextStyle(fontSize: 16, color: Colors.white),
                onPress: () {
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.blue,

            // Flaoting Action button Icon
            iconData: Icons.ac_unit,
            backGroundColor: Colors.white,
          ));
    }
  }
}
