class CreatorDTO {
  final int id;
  final String name;
  final String role;

  CreatorDTO(this.id, this.name, this.role);

  CreatorDTO.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        role = json['role'];
}
