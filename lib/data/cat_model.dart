double? checkDouble(value) {
  if (value is String) {
    return double.tryParse(value);
  } else if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else {
    return null;
  }
}

int? checkInteger(established) {
  if (established is String) {
    return int.tryParse(established);
  } else if (established is double) {
    return established.toInt();
  } else if (established is int) {
    return established;
  } else {
    return null;
  }
}

class CatData {
  String? name;
  String? breed;
  String? imagePath;
  double? starRating;
  double? ticketPrice;

  CatData(this.name, this.breed,this.imagePath ,this.starRating, this.ticketPrice);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "breed": breed,
      "image": imagePath,
      "starRating": starRating,
      "ticket_price": ticketPrice,
    };
  }

  CatData.fromJson(Map<dynamic, dynamic>? json) {
    if (json != null) {
      name = json["name"];
      breed = json["breed"];
      imagePath = json["image"];
      starRating = checkDouble(json['starRating']);
      ticketPrice = checkDouble(json["ticket_price"]);
    }
  }
}

class Cat {
  String? key;
  CatData? catData;

  Cat(this.key, this.catData);
}
