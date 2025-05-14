class CustomerRolesResponse {
  final List<CustomerRole> customerRoles;

  CustomerRolesResponse({required this.customerRoles});

  factory CustomerRolesResponse.fromJson(Map<String, dynamic> json) {
    return CustomerRolesResponse(
      customerRoles: (json['customer_roles'] as List)
          .map((e) => CustomerRole.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_roles': customerRoles.map((e) => e.toJson()).toList(),
    };
  }
}

class CustomerRole {
  final String name;
  final bool freeShipping;
  final bool taxExempt;
  final bool active;
  final bool isSystemRole;
  final String systemName;
  final bool enablePasswordLifetime;
  final int purchasedWithProductId;
  final int id;

  CustomerRole({
    required this.name,
    required this.freeShipping,
    required this.taxExempt,
    required this.active,
    required this.isSystemRole,
    required this.systemName,
    required this.enablePasswordLifetime,
    required this.purchasedWithProductId,
    required this.id,
  });

  factory CustomerRole.fromJson(Map<String, dynamic> json) {
    return CustomerRole(
      name: json['name'],
      freeShipping: json['free_shipping'],
      taxExempt: json['tax_exempt'],
      active: json['active'],
      isSystemRole: json['is_system_role'],
      systemName: json['system_name'],
      enablePasswordLifetime: json['enable_password_lifetime'],
      purchasedWithProductId: json['purchased_with_product_id'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'free_shipping': freeShipping,
      'tax_exempt': taxExempt,
      'active': active,
      'is_system_role': isSystemRole,
      'system_name': systemName,
      'enable_password_lifetime': enablePasswordLifetime,
      'purchased_with_product_id': purchasedWithProductId,
      'id': id,
    };
  }
}
