import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zealth_assignment/Models/ImageModel.dart';
import 'package:zealth_assignment/ViewModels/BaseModel.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';

import 'Widgets/ColorButton.dart';
import 'Widgets/CustomDatePicker.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final MainViewModel model =
        Provider.of<MainViewModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        model.resetDate();
        await model.getImages();
        return false;
      },
      child: Scaffold(
        floatingActionButton: Consumer<MainViewModel>(
          builder: (BuildContext context, model, Widget? child) {
            return model.viewState == ViewState.Busy
                ? ColoredButton(text: "Loading...", callback: () {})
                : ColoredButton(
                    text: "Reset",
                    callback: () async {
                      model.resetDate();
                      await model.getImages();
                    },
                  );
          },
        ),
        body: SafeArea(
            top: true,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back)),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: height * 0.125,
                            child: Center(
                              child: Text(
                                'Picture of the Day',
                                overflow: TextOverflow.fade,
                                // maxLines: 1,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                      ],
                    ),
                    Consumer<MainViewModel>(
                      builder: (context, model, child) {
                        ImageModel imageModel = model.imageModel;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.viewState == ViewState.Busy
                                ? CircularProgressIndicator()
                                : GestureDetector(
                                    onLongPress: () async {
                                      showModelDatePicker(
                                          context, model, true, height, width);
                                    },
                                    child: Center(
                                      child: CachedNetworkImage(
                                        useOldImageOnUrlChange: true,
                                        fit: BoxFit.cover,
                                        imageUrl: imageModel.url ??
                                            "https://apod.nasa.gov/apod/image/2112/NGC6822LRGB1024.jpg",
                                        placeholder: (context, imageurl) =>
                                            Shimmer.fromColors(
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey),
                                                ),
                                                direction: ShimmerDirection.ltr,
                                                baseColor: Colors.black38,
                                                highlightColor: Colors.black26),
                                        errorWidget:
                                            (context, imageurl, error) {
                                          print(error);
                                          return Center(
                                            child: Icon(
                                              Icons.error,
                                              size: 60,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              imageModel.title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              imageModel.copyright ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              imageModel.date ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              imageModel.explanation ?? "",
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.15,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
