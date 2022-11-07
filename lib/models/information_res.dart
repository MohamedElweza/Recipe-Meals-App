class Information {
  late int id;
  late String title;
  late int readyInMinutes;
  late int servings;
  late String sourceUrl;
  late String image;
  late String imageType;
  late String summary;

  Information({
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.image,
    required this.imageType,
    required this.summary,
  });
  Information.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.readyInMinutes = map['readyInMinutes'];
    this.servings = map['servings'];
    this.sourceUrl = map['sourceUrl'];
    this.image = map['image'];
    this.imageType = map['imageType'];
    this.summary = map['summary'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'title': this.title,
      'readyInMinutes': this.readyInMinutes,
      'servings': this.servings,
      'sourceUrl': this.sourceUrl,
      'image': this.image,
      'imageType': this.imageType,
      'summary': this.summary,
    };
    return map;
  }
}
