import 'package:equatable/equatable.dart';

class AccountEntity extends Equatable {
  final String accessToken;

  const AccountEntity(this.accessToken);

  factory AccountEntity.fromJson(Map<String, dynamic> json) => AccountEntity(json['accessToken']);

  @override
  List<Object?> get props => [accessToken];
}
