class StoreModel {
  String name;
  String url;
  bool sslEnabled;
  String? secureUrl;
  String hosts;
  int defaultLanguageId;
  List<LanguageModel> languages;
  List<CurrencyModel> currencies;
  int displayOrder;
  String companyName;
  String companyAddress;
  String companyPhoneNumber;
  String? companyVat;
  int id;

  StoreModel({
    required this.name,
    required this.url,
    required this.sslEnabled,
    this.secureUrl,
    required this.hosts,
    required this.defaultLanguageId,
    required this.languages,
    required this.currencies,
    required this.displayOrder,
    required this.companyName,
    required this.companyAddress,
    required this.companyPhoneNumber,
    this.companyVat,
    required this.id,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      name: json['name'],
      url: json['url'],
      sslEnabled: json['ssl_enabled'],
      secureUrl: json['secure_url'],
      hosts: json['hosts'],
      defaultLanguageId: json['default_language_id'],
      languages: (json['languages'] as List)
          .map((lang) => LanguageModel.fromJson(lang))
          .toList(),
      currencies: (json['currencies'] as List)
          .map((curr) => CurrencyModel.fromJson(curr))
          .toList(),
      displayOrder: json['display_order'],
      companyName: json['company_name'],
      companyAddress: json['company_address'],
      companyPhoneNumber: json['company_phone_number'],
      companyVat: json['company_vat'],
      id: json['id'],
    );
  }
}

class LanguageModel {
  String name;
  String languageCulture;
  String uniqueSeoCode;
  String flagImageFileName;
  bool rtl;
  bool limitedToStores;
  int defaultCurrencyId;
  bool published;
  int displayOrder;
  dynamic storeIds;
  int id;

  LanguageModel({
    required this.name,
    required this.languageCulture,
    required this.uniqueSeoCode,
    required this.flagImageFileName,
    required this.rtl,
    required this.limitedToStores,
    required this.defaultCurrencyId,
    required this.published,
    required this.displayOrder,
    this.storeIds,
    required this.id,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'],
      languageCulture: json['language_culture'],
      uniqueSeoCode: json['unique_seo_code'],
      flagImageFileName: json['flag_image_file_name'],
      rtl: json['rtl'],
      limitedToStores: json['limited_to_stores'],
      defaultCurrencyId: json['default_currency_id'],
      published: json['published'],
      displayOrder: json['display_order'],
      storeIds: json['store_ids'],
      id: json['id'],
    );
  }
}

class CurrencyModel {
  String name;
  String currencyCode;
  double rate;
  String displayLocale;
  String customFormatting;
  bool limitedToStores;
  bool published;
  int displayOrder;
  String createdOnUtc;
  String updatedOnUtc;
  String roundingType;
  dynamic storeIds;
  int id;

  CurrencyModel({
    required this.name,
    required this.currencyCode,
    required this.rate,
    required this.displayLocale,
    required this.customFormatting,
    required this.limitedToStores,
    required this.published,
    required this.displayOrder,
    required this.createdOnUtc,
    required this.updatedOnUtc,
    required this.roundingType,
    this.storeIds,
    required this.id,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      name: json['name'],
      currencyCode: json['currency_code'],
      rate: (json['rate'] as num).toDouble(),
      displayLocale: json['display_locale'],
      customFormatting: json['custom_formatting'],
      limitedToStores: json['limited_to_stores'],
      published: json['published'],
      displayOrder: json['display_order'],
      createdOnUtc: json['created_on_utc'],
      updatedOnUtc: json['updated_on_utc'],
      roundingType: json['rounding_type'],
      storeIds: json['store_ids'],
      id: json['id'],
    );
  }
}
