class ImageModel {
  String? explanation;
  String? title;
  String? hdurl;
  String? url;
  String? media_type;
  String? date;
  String? service_version;
  String? copyright;

  ImageModel(this.explanation, this.title, this.hdurl, this.url,
      this.media_type, this.date, this.service_version, this.copyright);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'hdurl': hdurl,
      'explanation': explanation,
      'copyright': copyright,
      'date': date,
      'service_version': service_version,
      'media_type': media_type,
    };
  }

  ImageModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        hdurl = json['hdurl'],
        explanation = json['explanation'],
        copyright = json['copyright'],
        date = json['date'],
        service_version = json['service_version'],
        media_type = json['media_type'],
        url = json['url'];
}
