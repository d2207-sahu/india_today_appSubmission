import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:india_today/Models/AstroModel.dart';
import 'package:india_today/ViewModels/AstroViewModel.dart';
import 'package:india_today/ViewModels/DailyPanchangViewModel.dart';

class AstroScreen extends StatefulWidget {
  const AstroScreen({Key? key}) : super(key: key);

  @override
  _AstroScreenState createState() => _AstroScreenState();
}

class _AstroScreenState extends State<AstroScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    AstroViewModel model = Provider.of<AstroViewModel>(context, listen: false);
    model.callAstroAPI();
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Talk to an Astrologer",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: ImageIcon(
                              AssetImage("assets/images/search.png"),
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              model.updateToSearch();
                            },
                          ),
                          PopupMenuButton(
                            offset: Offset(0, 50),

                            icon: ImageIcon(
                              AssetImage("assets/images/filter.png"),
                              color: Colors.orange,
                            ),
                            // key: _menuKey,
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    onTap: () {
                                      List<AstroModel> filterResults =
                                          model.astroList.where((element) {
                                        if (element.languages!
                                            .map((e) => e['name'])
                                            .contains("English")) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      }).toList();
                                      model.updateSearchResult(filterResults);
                                    },
                                    value: 3,
                                    child: Text("English")),
                                PopupMenuItem(
                                    value: 4,
                                    onTap: () {
                                      List<AstroModel> filterResults =
                                          model.astroList.where((element) {
                                        if (element.languages!
                                            .map((e) => e['name'])
                                            .contains("Hindi")) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      }).toList();
                                      model.updateSearchResult(filterResults);
                                    },
                                    child: Text("Hindi")),
                              ];
                            },
                          ),
                          PopupMenuButton(
                            offset: Offset(0, 50),
                            icon: ImageIcon(
                              AssetImage("assets/images/sort.png"),
                              color: Colors.orange,
                            ),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sort By:",
                                          style:
                                              TextStyle(color: Colors.orange),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                    onTap: () {
                                      model.updateOrder(1);
                                    },
                                    value: 1,
                                    child: Text("Experience - low to high")),
                                PopupMenuItem(
                                    value: 2,
                                    onTap: () {
                                      model.updateOrder(2);
                                    },
                                    child: Text("Experience - high to low")),
                                PopupMenuItem(
                                    value: 2,
                                    onTap: () {
                                      model.updateOrder(0);
                                    },
                                    child: Text("Pricing - low to high")),
                                PopupMenuItem(
                                    value: 2,
                                    onTap: () {
                                      model.updateOrder(3);
                                    },
                                    child: Text("Pricing - high to low"))
                              ];
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Consumer<AstroViewModel>(
                  builder: (context, model, child) {
                    return (model.search ?? false)
                        ? child ?? SizedBox()
                        : Container();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              offset: Offset(0, 2),
                              spreadRadius: 1,
                              color: Colors.black12)
                        ]),
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    child: Theme(
                      data: ThemeData(
                        primaryColor: Colors.orange,
                        colorScheme: ColorScheme.light(
                            secondary: Colors.orange, primary: Colors.orange),
                      ),
                      child: TextFormField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        onChanged: (value) {
                          print(value);
                          List<AstroModel> searchFirstNameResults = (value
                                  .isNotEmpty)
                              ? model.astroList.where((element) {
                                  print(element.skills!.map((e) => e['name']));
                                  if (element.firstName
                                      .toString()
                                      .contains(value)) {
                                    return true;
                                  } else if (element.lastName
                                      .toString()
                                      .contains(value)) {
                                    return true;
                                  } else if (element.languages!
                                      .map((e) => e['name'])
                                      .contains(value)) {
                                    return true;
                                  } else if (element.skills!
                                      .map((e) => e['name'])
                                      .contains(value)) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                }).toList()
                              : [];
                          print(searchFirstNameResults);
                          model.updateSearchResult(searchFirstNameResults);
                        },
                        decoration: InputDecoration(
                          hintText: "Search Astrologer",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                              width: 0,
                              color: Colors.white,
                            ),
                          ),
                          fillColor: Colors.white,
                          focusColor: Colors.orange,
                          hoverColor: Colors.orange,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.orange,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              _textEditingController.clear();
                              _focusNode.unfocus();
                              model.updateSearchResult([]);
                              model.updateToSearch();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<AstroViewModel>(
                  builder: (context, model, child) {
                    final double height = MediaQuery.of(context).size.height;
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _focusNode.hasFocus
                              ? Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(model.searchList.length == 0
                                      ? "No results. Showing All"
                                      : "${model.searchList.length} results"),
                                )
                              : model.searchList.length != 0
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: Text(model
                                                        .searchList.length ==
                                                    0
                                                ? "No results. Showing All"
                                                : "${model.searchList.length} results")),
                                        GestureDetector(
                                          onTap: () {
                                            model.updateSearchResult([]);
                                          },
                                          child: Container(
                                              color: Colors.orange,
                                              padding: EdgeInsets.all(20.0),
                                              child: Text("Remove Filter")),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                          model.astroList.isNotEmpty
                              ? model.searchList.isNotEmpty
                                  ? Container(
                                      height: height * 0.75,
                                      child: ListView.builder(
                                        itemCount: model.searchList.length + 1,
                                        itemBuilder: (context, index) {
                                          return index ==
                                                  model.searchList.length
                                              ? SizedBox(
                                                  height: height * 0.1,
                                                )
                                              : searchCard(
                                                  model.searchList[index]);
                                        },
                                      ),
                                    )
                                  : Container(
                                      height: height * 0.75,
                                      child: ListView.builder(
                                        itemCount: model.astroList.length + 1,
                                        itemBuilder: (context, index) {
                                          return index == model.astroList.length
                                              ? SizedBox(
                                                  height: height * 0.3,
                                                )
                                              : searchCard(
                                                  model.astroList[index]);
                                        },
                                      ),
                                    )
                              : ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: 50,
                                    maxWidth: 50,
                                  ),
                                  child: CircularProgressIndicator(
                                    color: Colors.orange,
                                  ),
                                ),
                        ]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchCard(AstroModel astro) {
    final double width = MediaQuery.of(context).size.width;
    Map? images = astro.images;
    late String image;
    if (images != null) {
      image = images['medium']['imageUrl'];
    } else {
      image = "";
    }

    List languages = astro.languages!.map((e) {
      return e["name"];
    }).toList();
    String language = "";
    for (int i = 0; i < languages.length; i++) {
      language = language == ""
          ? languages[i]
          : language.toString() + ", " + languages[i];
    }
    List skills = astro.skills!.map((e) {
      return e["name"];
    }).toList();
    String skill = "";
    for (int i = 0; i < skills.length; i++) {
      skill = skill == "" ? skills[i] : skill.toString() + ", " + skills[i];
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 0.0,
        right: 8,
        left: 8,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.15,
                height: width * 0.15,
                child: CachedNetworkImage(
                  imageUrl: "$image",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                width: width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${astro.firstName}" + " ${astro.lastName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          "${astro.experience?.toInt()} years",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Icon(
                              FontAwesomeIcons.shieldVirus,
                              size: 18,
                              color: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              /*ToDO*/

                              child: Text(
                                "$skill",
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Icon(
                              FontAwesomeIcons.language,
                              size: 18,
                              color: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),

                              /*ToDO*/
                              child: Text(
                                "$language",
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.6,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 18,
                              color: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),

                              /*ToDO*/
                              child: Text(
                                "₹${astro.minimumCallDurationCharges?.toInt()}/ min",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: astro.isOnCall ?? false
                            ? Colors.orange
                            : Colors.black54,
                        elevation: 3,
                        alignment: Alignment.center,
                        maximumSize: Size(
                          MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.width * 0.145,
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      onPressed: () {},
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Talk on Call',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
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
          SizedBox(
            height: 18.0,
          ),
          Divider(
            height: 0,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
