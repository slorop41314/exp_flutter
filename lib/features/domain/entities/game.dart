import 'package:new_flutter_bloc/features/domain/entities/base/base_model.dart';

class Game implements BaseModel {
  int? id;
  String? slug;
  String? name;
  String? released;
  bool? tba;
  String? backgroundImage;
  double? rating;
  int? ratingTop;
  Rating? ratings;
  int? ratingsCount;
  int? reviewsTextCount;
  int? added;
  Rating? addedByStatus;
  int? metacritic;
  int? playtime;
  int? suggestionsCount;
  String? updated;
  Rating? esrbRating;
  List<Platforms>? platforms;

  Game(
      {this.id,
      this.slug,
      this.name,
      this.released,
      this.tba,
      this.backgroundImage,
      this.rating,
      this.ratingTop,
      this.ratings,
      this.ratingsCount,
      this.reviewsTextCount,
      this.added,
      this.addedByStatus,
      this.metacritic,
      this.playtime,
      this.suggestionsCount,
      this.updated,
      this.esrbRating,
      this.platforms});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    released = json['released'];
    tba = json['tba'];
    backgroundImage = json['background_image'];
    rating = json['rating'];
    ratingTop = json['rating_top'];
    // ratings =
    //     json['ratings'] != null ? new Rating.fromJson(json['ratings']) : null;
    ratingsCount = json['ratings_count'];
    reviewsTextCount = json['reviews_text_count'];
    added = json['added'];
    addedByStatus = json['added_by_status'] != null
        ? new Rating.fromJson(json['added_by_status'])
        : null;
    metacritic = json['metacritic'];
    playtime = json['playtime'];
    suggestionsCount = json['suggestions_count'];
    updated = json['updated'];
    esrbRating = json['esrb_rating'] != null
        ? new Rating.fromJson(json['esrb_rating'])
        : null;
    if (json['platforms'] != null) {
      platforms = [];
      json['platforms'].forEach((v) {
        platforms?.add(new Platforms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['released'] = this.released;
    data['tba'] = this.tba;
    data['background_image'] = this.backgroundImage;
    data['rating'] = this.rating;
    data['rating_top'] = this.ratingTop;
    if (this.ratings != null) {
      data['ratings'] = this.ratings?.toJson();
    }
    data['ratings_count'] = this.ratingsCount;
    data['reviews_text_count'] = this.reviewsTextCount;
    data['added'] = this.added;
    if (this.addedByStatus != null) {
      data['added_by_status'] = this.addedByStatus?.toJson();
    }
    data['metacritic'] = this.metacritic;
    data['playtime'] = this.playtime;
    data['suggestions_count'] = this.suggestionsCount;
    data['updated'] = this.updated;
    if (this.esrbRating != null) {
      data['esrb_rating'] = this.esrbRating?.toJson();
    }
    if (this.platforms != null) {
      data['platforms'] = this.platforms?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rating {
  int? id;
  String? slug;
  String? name;

  Rating({this.id, this.slug, this.name});

  Rating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    return data;
  }
}

class Platforms {
  Rating? platform;
  String? releasedAt;
  Requirements? requirements;

  Platforms({this.platform, this.releasedAt, this.requirements});

  Platforms.fromJson(Map<String, dynamic> json) {
    platform =
        json['platform'] != null ? new Rating.fromJson(json['platform']) : null;
    releasedAt = json['released_at'];
    requirements = json['requirements'] != null
        ? new Requirements.fromJson(json['requirements'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.platform != null) {
      data['platform'] = this.platform?.toJson();
    }
    data['released_at'] = this.releasedAt;
    if (this.requirements != null) {
      data['requirements'] = this.requirements?.toJson();
    }
    return data;
  }
}

class Requirements {
  String? minimum;
  String? recommended;

  Requirements({this.minimum, this.recommended});

  Requirements.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    recommended = json['recommended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['recommended'] = this.recommended;
    return data;
  }
}
