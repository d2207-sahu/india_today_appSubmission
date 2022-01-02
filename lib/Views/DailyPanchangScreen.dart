import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:india_today/ViewModels/BaseModel.dart';
import 'package:india_today/ViewModels/DailyPanchangViewModel.dart';

class DailyPanchangScreen extends StatefulWidget {
  const DailyPanchangScreen({Key? key}) : super(key: key);

  @override
  _DailyPanchangScreenState createState() => _DailyPanchangScreenState();
}

class _DailyPanchangScreenState extends State<DailyPanchangScreen> {
  late Future locationFuture;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<PopupMenuButtonState> _menuKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    locationFuture = Provider.of<DailyPanchangViewModel>(context, listen: false)
        .callLocationAPI();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    DailyPanchangViewModel model =
        Provider.of<DailyPanchangViewModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage("assets/images/hamburger.png"),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Image(
                          image: AssetImage(
                            "assets/images/logo.png",
                          ),
                          height: 50,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {},
                          icon: ImageIcon(
                            AssetImage("assets/images/profile.png"),
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.35,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Talk to an Astrologer",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Expanded(
                        child: Text(
                          "India sa country known for its festival but knowing the exact Gates can sometimes be difficult. To ensure you do not miss out on the critical dates we bring you the daily panchang.",
                          maxLines: 5,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                        // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(color: Colors.orange.shade50),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 3, child: Text("Date")),
                                    Expanded(
                                      flex: 7,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        color: Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime(2023),
                                            ).then((value) {
                                              model.updateSelectedDate(value!);
                                            });
                                          },
                                          child:
                                              Consumer<DailyPanchangViewModel>(
                                            builder: (context, model, child) =>
                                                Text("${model.dateString}"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(flex: 3, child: Text("Location")),
                                    Expanded(
                                      flex: 7,
                                      child: FutureBuilder<dynamic>(
                                        future: locationFuture,
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.done:
                                              if (snapshot.hasError) {
                                                print(snapshot.error);
                                                return Container(
                                                    color: Colors.white,
                                                    child: Text(
                                                        "Error happened while fetching Location"));
                                              } else {
                                                if (snapshot.hasData) {
                                                  print(snapshot.data);
                                                  List data = snapshot.data;
                                                  return Container(
                                                    color: Colors.white,
                                                    child: Consumer<
                                                            DailyPanchangViewModel>(
                                                        builder: (context,
                                                            model, child) {
                                                      print("remaking");
                                                      return PopupMenuButton(
                                                        key: _menuKey,
                                                        offset: Offset(0, 50),
                                                        icon: TextFormField(
                                                          focusNode: _focusNode,
                                                          controller:
                                                              _textEditingController,
                                                          onChanged: (value) {
                                                            print("changing");
                                                            model.updateText(
                                                                value);
                                                            _menuKey
                                                                .currentState
                                                                ?.showButtonMenu();
                                                          },
                                                        ),
                                                        itemBuilder: (context) {
                                                          List searchResults =
                                                              (model.changedText
                                                                      .isNotEmpty)
                                                                  ? data.where(
                                                                      (element) {
                                                                      print(element[
                                                                          'placeName']);
                                                                      return element[
                                                                              'placeName']
                                                                          .toString()
                                                                          .toLowerCase()
                                                                          .contains(
                                                                              model.changedText);
                                                                    }).toList()
                                                                  : [];

                                                          return searchResults
                                                              .map((e) {
                                                            return PopupMenuItem(
                                                                onTap: () {
                                                                  print(e[
                                                                      'placeId']);
                                                                  model.updateLocationTag(
                                                                      e['placeId']);
                                                                  model
                                                                      .callForPanchang();

                                                                  _focusNode
                                                                      .unfocus();
                                                                },
                                                                child: Text(
                                                                  e['placeName'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        18.0,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                  ),
                                                                ));
                                                          }).toList();
                                                        },
                                                      );
                                                    }),
                                                  );
                                                } else {
                                                  return Container(
                                                      color: Colors.white,
                                                      child: Text(
                                                          "Error happened while fetching Location"));
                                                }
                                              }
                                            case ConnectionState.waiting:
                                              return SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            default:
                                              return SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<DailyPanchangViewModel>(
                  builder: (context, model, child) {
                    dynamic data = model.getPanchangData();
                    return model.viewState == ViewState.Busy
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator())
                        : model.hasPanchangData()
                            ? Container(
                                color: Colors.orange.shade50,
                                height: height * 0.7,
                                child: ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      if (data == null) {
                                        return Container();
                                      } else {
                                        switch (index) {
                                          case 1:
                                            return panchangCard(
                                                data['tithi'], index);
                                          case 2:
                                            return panchangCard(
                                                data['nakshatra'], index);
                                          case 3:
                                            return panchangCard(
                                                data['yog'], index);
                                          case 4:
                                            return panchangCard(
                                                data['karan'], index);
                                          default:
                                            return Container();
                                        }
                                      }
                                    }),
                              )
                            : Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //TODO check the mapped value.
  Widget panchangCard(dynamic data, int index) {
    late String heading;
    switch (index) {
      case 1:
        heading = 'tithi';
        break;
      case 2:
        heading = 'nakshatra';
        break;
      case 3:
        heading = 'yog';
        break;
      case 4:
        heading = 'karan';
        break;
      default:
        break;
    }
    Map<String, dynamic> details = data['details'];
    Map<String, dynamic> time = data['end_time'];
    List<Widget> rowTiles = [];
    for (int i = 0; i < details.keys.length; i++) {
      rowTiles.add(rowTile((details.keys.elementAt(i)),
          details['${details.keys.elementAt(i)}']));
    }
    rowTiles.add(rowTile("End Time",
        "${time['hour']} hr ${time['minute']} min ${time['second']} sec"));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$heading",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...rowTiles
        ],
      ),
    );
  }

  rowTile(String s, String t) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                "$s:",
                style: TextStyle(color: Colors.black54),
              )),
          Expanded(
              flex: 9,
              child: Text(
                t,
                style: TextStyle(color: Colors.black54),
              )),
        ],
      ),
    );
  }
}
