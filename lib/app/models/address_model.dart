class AddressModel {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? company;
  final int? countryId;
  final String? country;
  final int? stateProvinceId;
  final String? city;
  final String? address1;
  final String? address2;
  final String? zipPostalCode;
  final String? phoneNumber;
  final String? faxNumber;
  final String? customerAttributes;
  final DateTime? createdOnUtc;
  final String? province;

  AddressModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.company,
    this.countryId,
    this.country,
    this.stateProvinceId,
    this.city,
    this.address1,
    this.address2,
    this.zipPostalCode,
    this.phoneNumber,
    this.faxNumber,
    this.customerAttributes,
    this.createdOnUtc,
    this.province,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      company: json['company'],
      countryId: json['country_id'],
      country: json['country'],
      stateProvinceId: json['state_province_id'],
      city: json['city'],
      address1: json['address1'],
      address2: json['address2'],
      zipPostalCode: json['zip_postal_code'],
      phoneNumber: json['phone_number'],
      faxNumber: json['fax_number'],
      customerAttributes: json['customer_attributes'],
      createdOnUtc: json['created_on_utc'] != null
          ? DateTime.tryParse(json['created_on_utc'])
          : null,
      province: json['province'],
    );
  }
}
