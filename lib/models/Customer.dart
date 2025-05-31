class Customer {
  int? id;
  String name;
  String lastName;
  String email;
  bool active = true;

  Customer(this.id, this.name, this.lastName, this.email);

  Customer.withId(this.id, this.name, this.lastName, this.email, this.active);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'email': email,
      'active': active,
    };
  }

  static Customer fromJson(Map<String, dynamic> json) {
    return Customer.withId(
      json['id'],
      json['name'],
      json['lastName'],
      json['email'],
      json['active'],
    );
  }
}
