class TokenModel {
  String? accessToken;
  String? tokenType;
  String? createdAtUtc;
  String? expiresAtUtc;
  int? customerId;
  String? customerGuid;

  TokenModel({
    this.accessToken,
    this.tokenType,
    this.createdAtUtc,
    this.expiresAtUtc,
    this.customerId,
    this.customerGuid,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      createdAtUtc: json["created_at_utc"],
      expiresAtUtc: json["expires_at_utc"],
      customerId: json["customer_id"],
      customerGuid: json["customer_guid"],
    );
  }
}
