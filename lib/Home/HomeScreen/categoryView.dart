import 'package:esprit/Home/HomeScreen/my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:esprit/Home/HomeScreen/constant.dart';
import 'package:esprit/static.dart';
import 'package:esprit/Home/HomeScreen/loading.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/teacher.svg",
              textTop: " All Available",
              textBottom: "   Categories",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text("All Categories:", style: kTitleTextstyle),
                  SizedBox(height: 20),
                  CategoryCard(
                    text:
                        "Start learning your favorite programming language with learnly today!",
                    image: "assets/images/coding.png",
                    title: "Coding",
                  ),
                  CategoryCard(
                    text:
                        "Start learning marketing courses, you'll never know when  you become a marketing expert!",
                    image: "assets/images/marketing.png",
                    title: "Marketing",
                  ),
                  CategoryCard(
                    text:
                        "Are you into security? here you'll find all courses related to security!",
                    image: "assets/images/security.png",
                    title: "Security",
                  ),
                  CategoryCard(
                    text:
                        "Let's design your first mobile app UI! With learnly you can be a better designer!",
                    image: "assets/images/app.png",
                    title: "UI/UX Design",
                  ),
                  CategoryCard(
                    text:
                        "Are you into technology? you aim to achieve good things in life? then get exploring now!",
                    image: "assets/images/programming&tech.png",
                    title: "Programming & Tech",
                  ),
                  CategoryCard(
                    text:
                        "You want to get started with learning Digital Marketing? Get started now!",
                    image: "assets/images/digitalmarketing.png",
                    title: "Digital Marketing",
                  ),
                  CategoryCard(
                    text:
                        "Aiming to be a businessman in the future? start by learning the basics with Learnly!",
                    image: "assets/images/bussiness.png",
                    title: "Business",
                  ),
                  CategoryCard(
                    text:
                        "You want to get good at music? you came to the right place, start exploring now!",
                    image: "assets/images/music&audio.png",
                    title: "Music & Audio",
                  ),
                  CategoryCard(
                    text:
                        "You have a language in your mind that you want to learn? start searching for relevant courses now!",
                    image: "assets/images/languages.png",
                    title: "Languages",
                  ),
                  CategoryCard(
                    text:
                        "You want to take some lifestyle lessons and advices from known tutors & teachers?",
                    image: "assets/images/fun&lifestyle.png",
                    title: "Fun & Lifestyle",
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const CategoryCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(
              image,
              width: 140,
              height: 150,
            ),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ChosenCateg.chosen = title;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Loading()));
                        },
                        child: Text(
                          text,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
