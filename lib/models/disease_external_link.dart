// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DiseaseExternalLink {
  final int id;
  final String title;
  final String link;
  DiseaseExternalLink({
    required this.id,
    required this.title,
    required this.link,
  });

  DiseaseExternalLink copyWith({
    int? id,
    String? title,
    String? link,
  }) {
    return DiseaseExternalLink(
      id: id ?? this.id,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'link': link,
    };
  }

  factory DiseaseExternalLink.fromMap(Map<String, dynamic> map) {
    return DiseaseExternalLink(
      id: map['id'] as int,
      title: map['title'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiseaseExternalLink.fromJson(String source) =>
      DiseaseExternalLink.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DiseaseExternalLink(id: $id, title: $title, link: $link)';

  @override
  bool operator ==(covariant DiseaseExternalLink other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.link == link;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ link.hashCode;
}
