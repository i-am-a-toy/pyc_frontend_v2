enum Role {
  admin(0, 'ADMIN', '관리자'),
  pastor(1, 'PASTOR', '목사님'),
  pastorWife(2, 'PASTOR_WIFE', '사모님'),
  juniorPastor(3, 'JUNIOR_PASTOR', '전도사님'),
  groupLeader(4, 'GROUP_LEADER', '그룹리더'),
  newbieTeamLeader(5, 'NEWBIE_TEAM_LEADER', '새친구팀 팀장'),
  leader(6, 'LEADER', '셀리더'),
  member(7, 'MEMBER', '셀원'),
  newbie(8, 'NEWBIE', '새신자'),
  undefined(9, 'undefined', '');

  const Role(this.code, this.role, this.displayName);
  final int code;
  final String role;
  final String displayName;

  factory Role.getByCode(String role) {
    return Role.values.firstWhere((value) => value.role == role, orElse: () => Role.undefined);
  }

  factory Role.getByName(String name) {
    return Role.values.firstWhere((value) => value.displayName == name, orElse: () => Role.undefined);
  }

  bool isManager() {
    return code <= Role.groupLeader.code;
  }
}
