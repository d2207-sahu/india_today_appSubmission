import 'package:zealth_assignment/Models/AstroModel.dart';
import 'package:zealth_assignment/Services/AstroService.dart';
import 'package:zealth_assignment/ViewModels/BaseModel.dart';

import '../locator.dart';

class AstroViewModel extends BaseModel {
  final service = locator<AstroService>();
  List<AstroModel> astroList = [];
  List<AstroModel> searchList = [];
  List<AstroModel> filterResult = [];
  bool? search = false;

  Future<List<AstroModel>?> callAstroAPI() async {
    try {
      astroList = (await service.astroAPICall()) ?? [];
      notifyListeners();
      return astroList;
    } on Exception catch (e) {
      // TODO
    }
  }

  updateOrder(int i) {
    if (astroList.isNotEmpty && astroList != null) {
      switch (i) {
        case 0:
          // pricing
          astroList.sort((a, bs) => a.minimumCallDurationCharges!
              .compareTo(bs.minimumCallDurationCharges!));
          break;
        case 3:
          // pricing
          astroList.sort((a, bs) => bs.minimumCallDurationCharges!
              .compareTo(a.minimumCallDurationCharges!));
          break;
        case 1:
          // experience
          astroList.sort((a, bs) => a.experience!.compareTo(bs.experience!));
          break;
        case 2:
          // experience
          astroList.sort((a, bs) => bs.experience!.compareTo(a.experience!));
          break;
      }
      notifyListeners();
    }
  }

  updateToSearch() {
    search = !search!;
    notifyListeners();
  }

  updateFilterResult(List<AstroModel> filterResult) {
    this.filterResult = filterResult;
  }

  updateSearchResult(List<AstroModel> searchResults) {
    searchList = searchResults;
    notifyListeners();
  }
}
