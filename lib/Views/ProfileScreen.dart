import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';
import 'Widgets/ColorButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final MainViewModel model =
        Provider.of<MainViewModel>(context, listen: false);
    return Scaffold(
      floatingActionButton: ColoredButton(
        text: "Reset",
        callback: () async {
          model.resetDate();
        },
      ),
      body: SafeArea(
        top: true,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.1,
                child: Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.14,
                    width: height * 0.14,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 5),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/pp.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: width,
                    child: Text(
                      "Divyanshu Sahu",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      urlLauncher('mailto:divyanshusahu22@gmail.com');
                    },
                    child: Text(
                      "divyanshusahu22@gmail.com",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // urlLauncher('mailto:$mail');
                    },
                    child: Text(
                      "9907574095",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      urlLauncher('https://github.com/d2207-sahu');
                    },
                    child: Text(
                      "https://github.com/d2207-sahu",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      urlLauncher(
                          'https://stackoverflow.com/users/13139719/divyanshu-sahu');
                    },
                    child: Text(
                      "stackoverflow.com/divyanshu-sahu",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> urlLauncher(String url) async {
  if (await canLaunch(url).then((value) {
    print(value.toString());
    return value;
  })) {
    try {
      await launch(url);
    } catch (e) {
      print(e.toString());
    }
  } else {
    throw 'Could not launch $url';
  }
}
