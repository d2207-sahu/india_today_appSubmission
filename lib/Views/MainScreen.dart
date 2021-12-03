import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zealth_assignment/ViewModels/BaseModel.dart';
import 'package:zealth_assignment/ViewModels/ConnectivityProvider.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';
import 'package:zealth_assignment/Views/ImageScreen.dart';
import 'package:zealth_assignment/Views/ProfileScreen.dart';
import 'package:zealth_assignment/Views/Widgets/ColorButton.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    Provider.of<MainViewModel>(context, listen: false).setRecentDate();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Consumer<ConnectivityProvider>(
      builder: (context, connection, child) {
        return connection.isOnline
            ? child ?? Text('Error')
            : Scaffold(
                body: Container(
                  height: height,
                  child: Center(
                    child: Text(
                      'No Internet Connection',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
      },
      child: Scaffold(
        drawer: drawer(),
        floatingActionButton: Consumer<MainViewModel>(
          builder: (BuildContext context, MainViewModel model, Widget? child) {
            return model.viewState == ViewState.Busy
                ? ColoredButton(text: "Loading...", callback: () {})
                : ColoredButton(
                    text: "Show Image",
                    callback: () async {
                      await model.getImages();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) {
                        return ImageScreen();
                      }));
                    },
                  );
          },
        ),
        body: SafeArea(
          top: true,
          child: Consumer<MainViewModel>(
            builder: (context, model, child) {
              return Container(
                color: model.screenColor ?? Colors.grey,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                height: height,
                width: width,
                child: child,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                      flex: 5,
                      child: Center(
                        child: Container(
                          height: height * 0.25,
                          child: Text(
                            'Zealth',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.all(10),
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.black,
                          ),
                          iconSize: 35,
                          onPressed: () {
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ProfileScreen();
                            }));
                          },
                        )),
                  ],
                ),
                Container(
                  height: height * 0.1,
                ),
                Container(
                    height: height * 0.5,
                    child: Consumer<MainViewModel>(
                        builder: (BuildContext context, model, Widget? child) {
                      return Column(
                        children: [
                          //The first time the app will be launched, set the default date to 01-01-2000. On the subsequent
                          // launches of the app, make sure to show the input given by the user during the last use.
                          Text(
                            "${model.date.year}-${model.date.month}-${model.date.day}",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          ColoredButton(
                            size: 26,
                            text: "Choose a Date",
                            callback: () async {
                              showModelDatePicker(
                                  context, model, height, width);

                              /// Could have made the date picker show in the pdf
                              /// but it would have required to have 3 listviews
                              /// and each listview value would change the values of other two
                              /// As this was not compulsory i didn't added it.
                              /// But if it is required i will add on the request.
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModelDatePicker(context, MainViewModel model, height, width) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: height * 0.4,
                width: width,
                child: Theme(
                  data: ThemeData.light(),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: model.date,
                    // backgroundColor: Colors.black,
                    onDateTimeChanged: (date) {
                      print(date);
                      model.updateDate(date);
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

  Widget drawer() {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: height,
        width: width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height * 0.125,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.08,
                    child: Text(
                      'Zealth',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                    thickness: 2,
                  )
                ],
              ),
            ),
            ColoredButton(
              callback: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return ProfileScreen();
                }));
              },
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
