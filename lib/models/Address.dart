class Address {
  int? id;
  int? customerId;
  String zipCode;
  String street;
  String neighborhood;
  String city;

  Address(this.zipCode, this.street, this.neighborhood, this.city);

  static fromJson(Map<String, dynamic> json) {
    return Address(json['zipCode'], json['street'], json['neighborhood'], json['city']);
  }
}