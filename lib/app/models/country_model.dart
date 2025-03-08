class CountryModel {
  final String name;
  final bool allowsBilling;
  final bool allowsShipping;
  final String twoLetterIsoCode;
  final String threeLetterIsoCode;
  final int numericIsoCode;
  final bool subjectToVat;
  final int id;

  CountryModel({
    required this.name,
    required this.allowsBilling,
    required this.allowsShipping,
    required this.twoLetterIsoCode,
    required this.threeLetterIsoCode,
    required this.numericIsoCode,
    required this.subjectToVat,
    required this.id,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      allowsBilling: json['allows_billing'],
      allowsShipping: json['allows_shipping'],
      twoLetterIsoCode: json['two_letter_iso_code'],
      threeLetterIsoCode: json['ThreeLetterIsoCode'],
      numericIsoCode: json['numeric_iso_code'],
      subjectToVat: json['subject_to_vat'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'allows_billing': allowsBilling,
      'allows_shipping': allowsShipping,
      'two_letter_iso_code': twoLetterIsoCode,
      'ThreeLetterIsoCode': threeLetterIsoCode,
      'numeric_iso_code': numericIsoCode,
      'subject_to_vat': subjectToVat,
      'id': id,
    };
  }

  static List<CountryModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => CountryModel.fromJson(json)).toList();
  }
}
