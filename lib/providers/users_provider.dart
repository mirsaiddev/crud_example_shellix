import 'package:crud_example_shellix/models/element.dart';
import 'package:crud_example_shellix/models/response/http_response.dart';
import 'package:crud_example_shellix/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:crud_example_shellix/models/element.dart' as e;

class UsersProvider extends ChangeNotifier {
  UsersProvider() {
    getAllElements();
  }

  List<e.Element> allElements = [];
  bool allElementsGet = false;

  String? typedName = 'Mirsaid', typedImage = 'https://picsum.photos/536/354';
  DateTime? pickedBirthday;

  void setName(String name) {
    typedName = name;
    notifyListeners();
  }

  void setImage(String image) {
    typedImage = image;
    notifyListeners();
  }

  void setBirthday(String birthday) {
    pickedBirthday = DateTime.tryParse(birthday);
    notifyListeners();
  }

  Future<HttpResponse> addNewElement() async {
    debugPrint('addNewElement starts..');
    if (typedImage == null || typedName == null || pickedBirthday == null) {
      return HttpResponse(isSuccesfull: false, message: 'Lütfen tüm alanları doldurunuz.');
    }

    e.Element element = e.Element(
      name: typedName!,
      image: typedImage!,
      birthday: pickedBirthday!,
    );

    HttpResponse httpResponse = await ApiService().addNewElement(element);
    if (httpResponse.isSuccesfull) {
      allElements.add(element);
      notifyListeners();
      return HttpResponse(isSuccesfull: true, data: element, message: 'Başarılı');
    } else {
      debugPrint(httpResponse.message);
      return HttpResponse(isSuccesfull: false, data: httpResponse.data, message: httpResponse.data);
    }
  }

  Future<HttpResponse> deleteElement(e.Element element) async {
    HttpResponse httpResponse = await ApiService().deleteElement(element);
    if (httpResponse.isSuccesfull) {
      allElements.removeWhere((_element) => element.id == _element.id);
      notifyListeners();
      return HttpResponse(isSuccesfull: true, data: null, message: 'Başarılı');
    } else {
      debugPrint(httpResponse.message);
      return HttpResponse(isSuccesfull: false, data: httpResponse.data, message: httpResponse.data);
    }
  }

  Future<HttpResponse> updateElemenet(e.Element _element) async {
    if (typedImage == null || typedName == null || pickedBirthday == null) {
      return HttpResponse(isSuccesfull: false, message: 'Lütfen tüm alanları doldurunuz.');
    }

    e.Element element = e.Element(
      name: typedName!,
      image: typedImage!,
      birthday: pickedBirthday!,
    );
    element.id = _element.id;

    allElements[allElements.indexWhere((element) => _element.id == element.id)] = element;

    HttpResponse httpResponse = await ApiService().updateElement(element);
    if (httpResponse.isSuccesfull) {
      notifyListeners();
      return HttpResponse(isSuccesfull: true, data: element, message: 'Başarılı');
    } else {
      debugPrint(httpResponse.message);
      return HttpResponse(isSuccesfull: false, data: httpResponse.data, message: httpResponse.data);
    }
  }

  Future<void> getAllElements({bool force = false}) async {
    if (!force && allElementsGet) {
      return;
    }

    allElements = await ApiService().getAllElements();
    allElementsGet = true;
    notifyListeners();
  }
}
