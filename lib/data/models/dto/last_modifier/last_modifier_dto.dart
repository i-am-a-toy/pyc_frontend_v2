class LastModifierDTO {
  final int id;
  final String name;
  final String role;

  LastModifierDTO(this.id, this.name, this.role);

  LastModifierDTO.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        role = json['role'];
}
