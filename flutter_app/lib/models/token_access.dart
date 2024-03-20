class AccessToken {
  final String token;
  final String id;

  AccessToken({required this.token, required this.id});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(token: json['access_token'], id: json['id_user']);
  }

}