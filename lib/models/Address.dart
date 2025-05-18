class Address {
  int? id;
  int? customerId;
  String? description;
  String zipCode;
  int addressNumber = 0;
  String street;
  String neighborhood;
  String city;

  Address(this.id, this.customerId, this.description, this.zipCode, this.addressNumber, this.street, this.neighborhood, this.city);
  
  Address.fillWithSearch(this.zipCode, this.addressNumber, this.street, this.neighborhood, this.city);

  Address.complete(this.zipCode, this.addressNumber, this.street, this.neighborhood, this.city);


  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "customerId": customerId,
      "description": description,
      "zipCode": zipCode,
      "addressNumber": addressNumber,
      "street": street,
      "neighborhood": neighborhood,
      "city": city
    };
  }

  static fromSearchJson(Map<String, dynamic> json) {
    return Address.fillWithSearch(json['zipCode'], 0, json['street'], json['neighborhood'], json['city']);
  }

  static fromJson(Map<String, dynamic> json) {
    return Address(json['id'], json['customerId'], json['description'], json['zipCode'], json['adressNumber'], json['street'], json['neighborhood'], json['city']);
  }
}