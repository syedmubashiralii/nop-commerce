import 'package:nop_commerce/app/models/address_model.dart';

class CustomerModel {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? gender;
  final String? customerGuid;
  final bool? active;
  final bool? deleted;
  final bool? isTaxExempt;
  final bool? hasShoppingCartItems;
  final bool? isSystemAccount;
  final String? systemName;
  final String? lastIpAddress;
  final int? registeredInStoreId;
  final bool? subscribedToNewsletter;
  final String? vatNumber;
  final int? vatNumberStatusId;
  final bool? euCookieLawAccepted;
  final String? adminComment;
  final String? company;
  final String? password;
  final int? languageId;
  final int? currencyId;
  final DateTime? createdOnUtc;
  final DateTime? dateOfBirth;
  final DateTime? lastLoginDateUtc;
  final DateTime? lastActivityDateUtc;
  
  final AddressModel? billingAddress;
  final AddressModel? shippingAddress;
  final List<AddressModel>? addresses;

  CustomerModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.userName,
    this.gender,
    this.password,
    this.customerGuid,
     this.active,
     this.deleted,
     this.isTaxExempt,
     this.hasShoppingCartItems,
     this.isSystemAccount,
    this.systemName,
    this.lastIpAddress,
    this.registeredInStoreId,
    this.subscribedToNewsletter,
    this.vatNumber,
    this.vatNumberStatusId,
    this.euCookieLawAccepted,
    this.adminComment,
    this.company,
    this.languageId,
    this.currencyId,
    this.createdOnUtc,
    this.dateOfBirth,
    this.lastLoginDateUtc,
    this.lastActivityDateUtc,
    this.billingAddress,
    this.shippingAddress,
    this.addresses,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      password: json['password'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      userName: json['username'],
      gender: json['gender'],
      customerGuid: json['customer_guid'],
      active: json['active'] ?? false,
      deleted: json['deleted'] ?? false,
      isTaxExempt: json['is_tax_exempt'] ?? false,
      hasShoppingCartItems: json['has_shopping_cart_items'] ?? false,
      isSystemAccount: json['is_system_account'] ?? false,
      systemName: json['system_name'],
      lastIpAddress: json['last_ip_address'],
      registeredInStoreId: json['registered_in_store_id'],
      subscribedToNewsletter: json['subscribed_to_newsletter'],
      vatNumber: json['vat_number'],
      vatNumberStatusId: json['vat_number_status_id'],
      euCookieLawAccepted: json['eu_cookie_law_accepted'],
      adminComment: json['admin_comment'],
      company: json['company'],
      languageId: json['language_id'],
      currencyId: json['currency_id'],
      createdOnUtc: json['created_on_utc'] != null
          ? DateTime.tryParse(json['created_on_utc'])
          : null,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.tryParse(json['date_of_birth'])
          : null,
      lastLoginDateUtc: json['last_login_date_utc'] != null
          ? DateTime.tryParse(json['last_login_date_utc'])
          : null,
      lastActivityDateUtc: json['last_activity_date_utc'] != null
          ? DateTime.tryParse(json['last_activity_date_utc'])
          : null,
      billingAddress: json['billing_address'] != null
          ? AddressModel.fromJson(json['billing_address'])
          : null,
      shippingAddress: json['shipping_address'] != null
          ? AddressModel.fromJson(json['shipping_address'])
          : null,
      addresses: json['addresses'] != null
          ? List<AddressModel>.from(
              (json['addresses'] as List)
                  .map((e) => AddressModel.fromJson(e)),
            )
          : null,
    );
  }
}
