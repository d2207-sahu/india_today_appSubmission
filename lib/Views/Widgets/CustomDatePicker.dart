import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zealth_assignment/ViewModels/MainViewModel.dart';

void showModelDatePicker(
    context, MainViewModel model, bool callImages, height, width) {
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
                  minimumDate: DateTime(1995, 6, 16),
                  maximumDate: DateTime(2022),
                  onDateTimeChanged: (date) async {
                    print(date);
                    model.updateDate(date);
                    callImages ? await model.getImages() : print("");
                  },
                ),
              ),
            )
          ],
        );
      });
}
