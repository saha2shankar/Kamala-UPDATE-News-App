import 'dart:convert';

class NewsModel {
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsModel.fromRawJson(String str) {
    try {
      return NewsModel.fromJson(json.decode(str));
    } catch (e) {
      throw FormatException('Failed to parse NewsModel JSON: $e');
    }
  }

  String toRawJson() => json.encode(toJson());

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json[_JsonKeys.status] as String?,
      totalResults: json[_JsonKeys.totalResults] as int?,
      articles: json[_JsonKeys.articles] != null
          ? List<Article>.from(
              (json[_JsonKeys.articles] as List)
                  .map((x) => Article.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        _JsonKeys.status: status,
        _JsonKeys.totalResults: totalResults,
        _JsonKeys.articles: articles != null
            ? List<dynamic>.from(articles!.map((x) => x.toJson()))
            : null,
      };
}

class Article {
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromRawJson(String str) {
    try {
      return Article.fromJson(json.decode(str));
    } catch (e) {
      throw FormatException('Failed to parse Article JSON: $e');
    }
  }

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json[_JsonKeys.source] != null
          ? Source.fromJson(json[_JsonKeys.source] as Map<String, dynamic>)
          : null,
      author: json[_JsonKeys.author] as String?,
      title: json[_JsonKeys.title] as String?,
      description: json[_JsonKeys.description] as String?,
      url: json[_JsonKeys.url] as String?,
      urlToImage: json[_JsonKeys.urlToImage] as String?,
      publishedAt: json[_JsonKeys.publishedAt] as String?,
      content: json[_JsonKeys.content] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        _JsonKeys.source: source?.toJson(),
        _JsonKeys.author: author,
        _JsonKeys.title: title,
        _JsonKeys.description: description,
        _JsonKeys.url: url,
        _JsonKeys.urlToImage: urlToImage,
        _JsonKeys.publishedAt: publishedAt,
        _JsonKeys.content: content,
      };
}

class Source {
  final dynamic id;
  final String? name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromRawJson(String str) {
    try {
      return Source.fromJson(json.decode(str));
    } catch (e) {
      throw FormatException('Failed to parse Source JSON: $e');
    }
  }

  String toRawJson() => json.encode(toJson());

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json[_JsonKeys.id],
      name: json[_JsonKeys.name] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        _JsonKeys.id: id,
        _JsonKeys.name: name,
      };
}

// Constants for JSON keys to avoid typos
abstract class _JsonKeys {
  static const String status = 'status';
  static const String totalResults = 'totalResults';
  static const String articles = 'articles';
  static const String source = 'source';
  static const String author = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';
  static const String id = 'id';
  static const String name = 'name';
}
