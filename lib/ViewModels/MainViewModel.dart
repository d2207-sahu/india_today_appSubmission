import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zealth_assignment/Models/ImageModel.dart';
import 'package:zealth_assignment/Services/ApiServices.dart';
import 'package:intl/intl.dart';
import '../Constant.dart';
import '../locator.dart';
import 'BaseModel.dart';

class MainViewModel extends BaseModel {
  final ApiServices _api = locator<ApiServices>();

  /// date - 21, month - 12, year - 2000
  /// day - 2000-12-21 | as required by NASA api
  int day = 01, month = 01, year = 2000;
  DateTime date = DateTime(2000, 01, 01);
  Color? screenColor = Colors.black12;
  ImageModel _imageModel = ImageModel("explanation", "title", "hdurl", "url",
      "media_type", "date", "service_version", "copyright");
  bool hasInternet = false;

  ImageModel get imageModel => _imageModel;

  Future<ImageModel> getImages() async {
    setBusy();
    ImageModel imageModel = await _api.getImages(date);
    _imageModel = imageModel;
    setIdle();
    return imageModel;
  }

  updateCustomDate({int? month, int? year, int? day}) async {
    month == null ? print("") : this.month = month;
    year == null ? print("") : this.year = year;
    day == null ? print("") : this.day = day;
    DateTime date = DateTime(this.year, this.month, this.day);
    this.date = date;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("recentDate", date.toString());
    String nameOfDay = DateFormat('EEEE').format(this.date);
    updateColor(nameOfDay);
    notifyListeners();
  }

  resetDate() async {
    setBusy();
    this.date = DateTime(2000, 01, 01);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("recentDate", date.toString());
    String nameOfDay = DateFormat('EEEE').format(this.date);
    updateColor(nameOfDay);
    setIdle();
    notifyListeners();
  }

  setRecentDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String date = await preferences.getString("recentDate") ?? "2000-01-01";
    preferences.getString('recentDate') == null
        ? this.date = DateTime(2000, 01, 01)
        : this.date = DateTime.parse(date);
    String nameOfDay = DateFormat('EEEE').format(this.date);
    updateColor(nameOfDay);
    notifyListeners();
  }

  updateDate(DateTime date) async {
    setIdle();
    this.date = date;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("recentDate", date.toString());
    String nameOfDay = DateFormat('EEEE').format(this.date);
    updateColor(nameOfDay);
    notifyListeners();
  }

  void updateColor(String nameOfDay) {
    this.screenColor = mappedColor['$nameOfDay'];
    notifyListeners();
  }
}
