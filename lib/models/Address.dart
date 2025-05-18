class Address {
  int? id;
  int? customerId;
  String? description;
  String zipCode;
  String street;
  String neighborhood;
  String city;

  Address(this.id, this.customerId, this.description, this.zipCode, this.street, this.neighborhood, this.city);
  
  Address.fillWithSearch(this.zipCode, this.street, this.neighborhood, this.city);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "customerId": customerId,
      "description": description,
      "zipCode": zipCode,
      "street": street,
      "neighborhood": neighborhood,
      "city": city
    };
  }

  static fromSearchJson(Map<String, dynamic> json) {
    return Address.fillWithSearch(json['zipCode'], json['street'], json['neighborhood'], json['city']);
  }

  static fromJson(Map<String, dynamic> json) {
    return Address(json['id'], json['customerId'], json['description'], json['zipCode'], json['street'], json['neighborhood'], json['city']);
  }
}