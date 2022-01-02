import 'BaseModel.dart';

class MainViewModel extends BaseModel {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void changePage(int index) {
    this._currentPage = index;
    notifyListeners();
  }
}
