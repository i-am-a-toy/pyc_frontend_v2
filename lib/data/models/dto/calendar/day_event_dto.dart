class DayEventDTO {
  final DateTime day;
  final bool isExist;

  DayEventDTO(this.day, this.isExist);

  DayEventDTO.fromJSON(Map<String, dynamic> json)
      : day = DateTime.parse(json['day']),
        isExist = json['isExist'];
}
