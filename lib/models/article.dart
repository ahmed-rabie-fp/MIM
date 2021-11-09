class Article {
  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.actualDate,
    required this.startDate,
    required this.endDate,
    required this.additionalInformation,
    required this.url,
    required this.images,
  });
  late final int id;
  late final String title;
  late final String description;
  late final String actualDate;
  late final String startDate;
  late final String endDate;
  late final String additionalInformation;
  late final String url;
  late final List<String> images;

  Article.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    actualDate = json['actual_date'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    additionalInformation = json['additional_information']?? "";
    url = json['url'] ?? "";
    images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['description'] = description;
    _data['actual_date'] = actualDate;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['additional_information'] = additionalInformation;
    _data['url'] = url;
    _data['images'] = images;
    return _data;
  }
}