class AccountEntity {
  final String accessToken;

  AccountEntity(this.accessToken);

  factory AccountEntity.fromJson(Map<String, dynamic> json) => AccountEntity(json['accessToken']);
}
