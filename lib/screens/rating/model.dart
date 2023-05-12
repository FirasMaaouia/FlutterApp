class Rating {
  int value;
  String ratedBy;
  Rating(this.value, this.ratedBy);
  // ignore: non_constant_identifier_names
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["value"] = value;
    map["ratedBy"] = ratedBy;
    return map;
  }
}

class Comment {
  String content;
  String commentedBy;
  Comment(this.content, this.commentedBy);
  // ignore: non_constant_identifier_names
  Map<String, dynamic> TojsonData() {
    var map = new Map<String, dynamic>();
    map["content"] = content;
    map["commentedBy"] = commentedBy;
    return map;
  }
}
