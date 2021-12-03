import 'package:flutter/material.dart';

enum ViewState { Busy, Idle }

class BaseModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => _viewState;

  void setBusy() {
    _viewState == ViewState.Busy
        ? print('Already Busy')
        : _viewState = ViewState.Busy;
    notifyListeners();
  }

  void setIdle() {
    _viewState == ViewState.Idle
        ? print('Already Idle')
        : _viewState = ViewState.Idle;
    notifyListeners();
  }
}
