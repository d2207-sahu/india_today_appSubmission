import '../Services/DailyPanchangService.dart';
import '../locator.dart';
import 'BaseModel.dart';

class DailyPanchangViewModel extends BaseModel {
  final service = locator<DailyPanchangService>();
  final locationList = [];
  late DateTime selectedDate = DateTime.now();
  late String dateString = "Select Date";
  late String locationTag;
  late String changedText;
  Map<DateTime, dynamic> panchangData = Map<DateTime, dynamic>();
  String month(int i) {
    switch (i) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  updateSelectedDate(DateTime value) {
    selectedDate = value;
    dateString = selectedDate.day.toString() +
        " " +
        month(selectedDate.month).toString() +
        ", " +
        selectedDate.year.toString();
    notifyListeners();
  }

  updateLocationTag(String tag) {
    locationTag = tag;
    notifyListeners();
  }

  updateText(String value) {
    changedText = value;
    notifyListeners();
  }

  Future callLocationAPI() async {
    try {
      if (locationList.isEmpty) {
        List data = await service.fetchLocationAPI();
        return data;
      } else {
        return locationList;
      }
    } catch (e) {}
  }

  callForPanchang() async {
    print("hi");
    try {
      if (!panchangData.containsKey(selectedDate)) {
        if (locationTag != "") {
          dynamic locationData = await service.callPanchang(selectedDate.day,
              selectedDate.month, selectedDate.year, locationTag);
          panchangData.putIfAbsent(selectedDate, () => locationData);
        }
        throw "Location Not Selected";
      } else {
        return panchangData[selectedDate];
      }
    } on Exception catch (e) {
      // TODO
    }
  }

  hasPanchangData() {
    return panchangData.containsKey(selectedDate);
  }

  getPanchangData() {
    return panchangData[selectedDate];
  }
}
