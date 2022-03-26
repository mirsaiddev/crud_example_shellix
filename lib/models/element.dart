class Element {
  Element({
    required this.name,
    required this.image,
    required this.birthday,
  });
  late final String name;
  late final String image;
  late final DateTime birthday;
  late final String id;

  int getYersOld() {
    var now = DateTime.now();
    int nowYear = now.year;
    int birthdayYear = birthday.year;
    int yearsOld = nowYear - birthdayYear;
    return yearsOld;
  }

  Element.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    birthday = DateTime.parse(json['birthday']);
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['image'] = image;
    _data['birthday'] = birthday.toString();
    return _data;
  }
}
