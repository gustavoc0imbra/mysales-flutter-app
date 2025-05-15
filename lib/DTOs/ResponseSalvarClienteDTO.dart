class ResponseSalvarClienteDTO {
  ResponseSalvarClienteDTO(this.id, this.name, this.lastName, this.email, this.active);

  int id;
  String name;
  String lastName;
  String email;
  bool active;

  static ResponseSalvarClienteDTO fromJson(Map<String, dynamic> json) {
    return ResponseSalvarClienteDTO(json['id'], json['name'], json['lastName'], json['email'], json['active']);
  }
}