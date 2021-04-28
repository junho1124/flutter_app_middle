import 'dates.dart';
import 'results.dart';

class MovieResult {
  Dates dates;
  int page;
  List<Results> results;
  int totalPages;
  int totalResults;

  MovieResult({
      this.dates, 
      this.page, 
      this.results, 
      this.totalPages, 
      this.totalResults});

  MovieResult.fromJson(dynamic json) {
    dates = json["dates"] != null ? Dates.fromJson(json["dates"]) : null;
    page = json["page"];
    if (json["results"] != null) {
      results = [];
      json["results"].forEach((v) {
        results.add(Results.fromJson(v));
      });
    }
    totalPages = json["total_pages"];
    totalResults = json["total_results"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (dates != null) {
      map["dates"] = dates.toJson();
    }
    map["page"] = page;
    if (results != null) {
      map["results"] = results.map((v) => v.toJson()).toList();
    }
    map["total_pages"] = totalPages;
    map["total_results"] = totalResults;
    return map;
  }

}