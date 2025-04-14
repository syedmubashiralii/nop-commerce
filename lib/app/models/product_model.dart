class ProductList {
  List<Products>? products;

  ProductList({this.products});

  ProductList.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  bool? visibleIndividually;
  String? name;
  String? shortDescription;
  String? fullDescription;
  bool? showOnHomePage;
  String? metaKeywords; // Changed from Null to String
  String? metaDescription; // Changed from Null to String
  String? metaTitle; // Changed from Null to String
  bool? allowCustomerReviews;
  int? approvedRatingSum;
  int? notApprovedRatingSum;
  int? approvedTotalReviews;
  int? notApprovedTotalReviews;
  String? sku;
  String? manufacturerPartNumber; // Changed from Null to String
  String? gtin; // Changed from Null to String
  bool? isGiftCard;
  bool? requireOtherProducts;
  bool? automaticallyAddRequiredProducts;
  List<int>? requiredProductIds; // Changed from <Null> to <int>
  bool? isDownload;
  bool? unlimitedDownloads;
  int? maxNumberOfDownloads;
  int? downloadExpirationDays; // Changed from Null to int
  bool? hasSampleDownload;
  bool? hasUserAgreement;
  bool? isRecurring;
  int? recurringCycleLength;
  int? recurringTotalCycles;
  bool? isRental;
  int? rentalPriceLength;
  bool? isShipEnabled;
  bool? isFreeShipping;
  bool? shipSeparately;
  double? additionalShippingCharge = 0;
  bool? isTaxExempt;
  int? taxCategoryId;
  bool?
      isTelecommunicationsOrBroadcastingOrElectronicServices; // Changed from Null to bool
  bool? useMultipleWarehouses;
  int? manageInventoryMethodId;
  int? stockQuantity;
  bool? displayStockAvailability;
  bool? displayStockQuantity;
  int? minStockQuantity;
  int? lowStockActivityId;
  int? notifyAdminForQuantityBelow;
  bool? allowBackInStockSubscriptions;
  int? orderMinimumQuantity;
  int? orderMaximumQuantity;
  List<int>? allowedQuantities; // Changed from Null to <int>
  bool? allowAddingOnlyExistingAttributeCombinations;
  bool? disableBuyButton;
  bool? disableWishlistButton;
  bool? availableForPreOrder;
  String? preOrderAvailabilityStartDateTimeUtc; // Changed from Null to String
  bool? callForPrice;
  double? price;
  double? oldPrice;
  double? productCost;
  double? specialPrice; // Changed from Null to double
  String? specialPriceStartDateTimeUtc; // Changed from Null to String
  String? specialPriceEndDateTimeUtc; // Changed from Null to String
  bool? customerEntersPrice;
  double? minimumCustomerEnteredPrice;
  double? maximumCustomerEnteredPrice = 0;
  bool? basepriceEnabled;
  double? basepriceAmount = 0;
  double? basepriceBaseAmount = 0;
  bool? markAsNew;
  String? markAsNewStartDateTimeUtc; // Changed from Null to String
  String? markAsNewEndDateTimeUtc; // Changed from Null to String
  bool? hasTierPrices;
  bool? hasDiscountsApplied;
  double? weight;
  double? length;
  double? width;
  double? height;
  String? availableStartDateTimeUtc; // Changed from Null to String
  String? availableEndDateTimeUtc; // Changed from Null to String
  int? displayOrder = 0;
  bool? published;
  bool? deleted;
  String? createdOnUtc;
  String? updatedOnUtc;
  String? productType;
  int? parentGroupedProductId;
  List<int>? roleIds; // Changed from <Null> to <int>
  List<int>? discountIds; // Changed from <Null> to <int>
  List<int>? storeIds; // Changed from <Null> to <int>
  List<int>? manufacturerIds;
  List<Images>? images;
  List<Attributes>? attributes;
  List<int>? productAttributeCombinations; // Changed from <Null> to <int>
  List<ProductSpecificationAttributes>? productSpecificationAttributes;
  List<int>? associatedProductIds;
  List<String>? tags;
  int? vendorId;
  String? seName;
  int? id;

  Products(
      {this.visibleIndividually,
      this.name,
      this.shortDescription,
      this.fullDescription,
      this.showOnHomePage,
      this.metaKeywords,
      this.metaDescription,
      this.metaTitle,
      this.allowCustomerReviews,
      this.approvedRatingSum,
      this.notApprovedRatingSum,
      this.approvedTotalReviews,
      this.notApprovedTotalReviews,
      this.sku,
      this.manufacturerPartNumber,
      this.gtin,
      this.isGiftCard,
      this.requireOtherProducts,
      this.automaticallyAddRequiredProducts,
      this.requiredProductIds,
      this.isDownload,
      this.unlimitedDownloads,
      this.maxNumberOfDownloads,
      this.downloadExpirationDays,
      this.hasSampleDownload,
      this.hasUserAgreement,
      this.isRecurring,
      this.recurringCycleLength,
      this.recurringTotalCycles,
      this.isRental,
      this.rentalPriceLength,
      this.isShipEnabled,
      this.isFreeShipping,
      this.shipSeparately,
      this.additionalShippingCharge,
      this.isTaxExempt,
      this.taxCategoryId,
      this.isTelecommunicationsOrBroadcastingOrElectronicServices,
      this.useMultipleWarehouses,
      this.manageInventoryMethodId,
      this.stockQuantity,
      this.displayStockAvailability,
      this.displayStockQuantity,
      this.minStockQuantity,
      this.lowStockActivityId,
      this.notifyAdminForQuantityBelow,
      this.allowBackInStockSubscriptions,
      this.orderMinimumQuantity,
      this.orderMaximumQuantity,
      this.allowedQuantities,
      this.allowAddingOnlyExistingAttributeCombinations,
      this.disableBuyButton,
      this.disableWishlistButton,
      this.availableForPreOrder,
      this.preOrderAvailabilityStartDateTimeUtc,
      this.callForPrice,
      this.price,
      this.oldPrice,
      this.productCost,
      this.specialPrice,
      this.specialPriceStartDateTimeUtc,
      this.specialPriceEndDateTimeUtc,
      this.customerEntersPrice,
      this.minimumCustomerEnteredPrice,
      this.maximumCustomerEnteredPrice,
      this.basepriceEnabled,
      this.basepriceAmount,
      this.basepriceBaseAmount,
      this.markAsNew,
      this.markAsNewStartDateTimeUtc,
      this.markAsNewEndDateTimeUtc,
      this.hasTierPrices,
      this.hasDiscountsApplied,
      this.weight,
      this.length,
      this.width,
      this.height,
      this.availableStartDateTimeUtc,
      this.availableEndDateTimeUtc,
      this.displayOrder,
      this.published,
      this.deleted,
      this.createdOnUtc,
      this.updatedOnUtc,
      this.productType,
      this.parentGroupedProductId,
      this.roleIds,
      this.discountIds,
      this.storeIds,
      this.manufacturerIds,
      this.images,
      this.attributes,
      this.productAttributeCombinations,
      this.productSpecificationAttributes,
      this.associatedProductIds,
      this.tags,
      this.vendorId,
      this.seName,
      this.id});

  Products.fromJson(Map<String, dynamic> json) {
    visibleIndividually = json['visible_individually'];
    name = json['name'];
    shortDescription = json['short_description'];
    fullDescription = json['full_description'];
    showOnHomePage = json['show_on_home_page'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    metaTitle = json['meta_title'];
    allowCustomerReviews = json['allow_customer_reviews'];
    approvedRatingSum = json['approved_rating_sum'];
    notApprovedRatingSum = json['not_approved_rating_sum'];
    approvedTotalReviews = json['approved_total_reviews'];
    notApprovedTotalReviews = json['not_approved_total_reviews'];
    sku = json['sku'];
    manufacturerPartNumber = json['manufacturer_part_number'];
    gtin = json['gtin'];
    isGiftCard = json['is_gift_card'];
    requireOtherProducts = json['require_other_products'];
    automaticallyAddRequiredProducts =
        json['automatically_add_required_products'];
    if (json['required_product_ids'] != null) {
      requiredProductIds = <int>[];
      json['required_product_ids'].forEach((v) {
        requiredProductIds!.add(v);
      });
    }
    isDownload = json['is_download'];
    unlimitedDownloads = json['unlimited_downloads'];
    maxNumberOfDownloads = json['max_number_of_downloads'];
    downloadExpirationDays = json['download_expiration_days'];
    hasSampleDownload = json['has_sample_download'];
    hasUserAgreement = json['has_user_agreement'];
    isRecurring = json['is_recurring'];
    recurringCycleLength = json['recurring_cycle_length'];
    recurringTotalCycles = json['recurring_total_cycles'];
    isRental = json['is_rental'];
    rentalPriceLength = json['rental_price_length'];
    isShipEnabled = json['is_ship_enabled'];
    isFreeShipping = json['is_free_shipping'];
    shipSeparately = json['ship_separately'];
    additionalShippingCharge = json['additional_shipping_charge'];
    isTaxExempt = json['is_tax_exempt'];
    taxCategoryId = json['tax_category_id'];
    isTelecommunicationsOrBroadcastingOrElectronicServices =
        json['is_telecommunications_or_broadcasting_or_electronic_services'];
    useMultipleWarehouses = json['use_multiple_warehouses'];
    manageInventoryMethodId = json['manage_inventory_method_id'];
    stockQuantity = json['stock_quantity'];
    displayStockAvailability = json['display_stock_availability'];
    displayStockQuantity = json['display_stock_quantity'];
    minStockQuantity = json['min_stock_quantity'];
    lowStockActivityId = json['low_stock_activity_id'];
    notifyAdminForQuantityBelow = json['notify_admin_for_quantity_below'];
    allowBackInStockSubscriptions = json['allow_back_in_stock_subscriptions'];
    orderMinimumQuantity = json['order_minimum_quantity'];
    orderMaximumQuantity = json['order_maximum_quantity'];
    allowedQuantities = json['allowed_quantities'];
    allowAddingOnlyExistingAttributeCombinations =
        json['allow_adding_only_existing_attribute_combinations'];
    disableBuyButton = json['disable_buy_button'];
    disableWishlistButton = json['disable_wishlist_button'];
    availableForPreOrder = json['available_for_pre_order'];
    preOrderAvailabilityStartDateTimeUtc =
        json['pre_order_availability_start_date_time_utc'];
    callForPrice = json['call_for_price'];
    price = json['price'];
    oldPrice = json['old_price'];
    productCost = json['product_cost'];
    specialPrice = json['special_price'];
    specialPriceStartDateTimeUtc = json['special_price_start_date_time_utc'];
    specialPriceEndDateTimeUtc = json['special_price_end_date_time_utc'];
    customerEntersPrice = json['customer_enters_price'];
    minimumCustomerEnteredPrice = json['minimum_customer_entered_price'];
    maximumCustomerEnteredPrice = json['maximum_customer_entered_price'];
    basepriceEnabled = json['baseprice_enabled'];
    basepriceAmount = json['baseprice_amount'];
    basepriceBaseAmount = json['baseprice_base_amount'];
    markAsNew = json['mark_as_new'];
    markAsNewStartDateTimeUtc = json['mark_as_new_start_date_time_utc'];
    markAsNewEndDateTimeUtc = json['mark_as_new_end_date_time_utc'];
    hasTierPrices = json['has_tier_prices'];
    hasDiscountsApplied = json['has_discounts_applied'];
    weight = json['weight'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    availableStartDateTimeUtc = json['available_start_date_time_utc'];
    availableEndDateTimeUtc = json['available_end_date_time_utc'];
    displayOrder = json['display_order'];
    published = json['published'];
    deleted = json['deleted'];
    createdOnUtc = json['created_on_utc'];
    updatedOnUtc = json['updated_on_utc'];
    productType = json['product_type'];
    parentGroupedProductId = json['parent_grouped_product_id'];
    if (json['role_ids'] != null) {
      roleIds = <int>[];
      json['role_ids'].forEach((v) {
        roleIds!.add(v);
      });
    }
    if (json['discount_ids'] != null) {
      discountIds = <int>[];
      json['discount_ids'].forEach((v) {
        discountIds!.add(v);
      });
    }
    if (json['store_ids'] != null) {
      storeIds = <int>[];
      json['store_ids'].forEach((v) {
        storeIds!.add(v);
      });
    }
    manufacturerIds = json['manufacturer_ids'].cast<int>();
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    if (json['product_attribute_combinations'] != null) {
      productAttributeCombinations = <int>[];
      json['product_attribute_combinations'].forEach((v) {
        productAttributeCombinations!.add(v);
      });
    }
    if (json['product_specification_attributes'] != null) {
      productSpecificationAttributes = <ProductSpecificationAttributes>[];
      json['product_specification_attributes'].forEach((v) {
        productSpecificationAttributes!
            .add(ProductSpecificationAttributes.fromJson(v));
      });
    }
    associatedProductIds = json['associated_product_ids'].cast<int>();
    tags = json['tags'].cast<String>();
    vendorId = json['vendor_id'];
    seName = json['se_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visible_individually'] = visibleIndividually;
    data['name'] = name;
    data['short_description'] = shortDescription;
    data['full_description'] = fullDescription;
    data['show_on_home_page'] = showOnHomePage;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['meta_title'] = metaTitle;
    data['allow_customer_reviews'] = allowCustomerReviews;
    data['approved_rating_sum'] = approvedRatingSum;
    data['not_approved_rating_sum'] = notApprovedRatingSum;
    data['approved_total_reviews'] = approvedTotalReviews;
    data['not_approved_total_reviews'] = notApprovedTotalReviews;
    data['sku'] = sku;
    data['manufacturer_part_number'] = manufacturerPartNumber;
    data['gtin'] = gtin;
    data['is_gift_card'] = isGiftCard;
    data['require_other_products'] = requireOtherProducts;
    data['automatically_add_required_products'] =
        automaticallyAddRequiredProducts;
    if (requiredProductIds != null) {
      data['required_product_ids'] = requiredProductIds;
    }
    data['is_download'] = isDownload;
    data['unlimited_downloads'] = unlimitedDownloads;
    data['max_number_of_downloads'] = maxNumberOfDownloads;
    data['download_expiration_days'] = downloadExpirationDays;
    data['has_sample_download'] = hasSampleDownload;
    data['has_user_agreement'] = hasUserAgreement;
    data['is_recurring'] = isRecurring;
    data['recurring_cycle_length'] = recurringCycleLength;
    data['recurring_total_cycles'] = recurringTotalCycles;
    data['is_rental'] = isRental;
    data['rental_price_length'] = rentalPriceLength;
    data['is_ship_enabled'] = isShipEnabled;
    data['is_free_shipping'] = isFreeShipping;
    data['ship_separately'] = shipSeparately;
    data['additional_shipping_charge'] = additionalShippingCharge;
    data['is_tax_exempt'] = isTaxExempt;
    data['tax_category_id'] = taxCategoryId;
    data['is_telecommunications_or_broadcasting_or_electronic_services'] =
        isTelecommunicationsOrBroadcastingOrElectronicServices;
    data['use_multiple_warehouses'] = useMultipleWarehouses;
    data['manage_inventory_method_id'] = manageInventoryMethodId;
    data['stock_quantity'] = stockQuantity;
    data['display_stock_availability'] = displayStockAvailability;
    data['display_stock_quantity'] = displayStockQuantity;
    data['min_stock_quantity'] = minStockQuantity;
    data['low_stock_activity_id'] = lowStockActivityId;
    data['notify_admin_for_quantity_below'] = notifyAdminForQuantityBelow;
    data['allow_back_in_stock_subscriptions'] = allowBackInStockSubscriptions;
    data['order_minimum_quantity'] = orderMinimumQuantity;
    data['order_maximum_quantity'] = orderMaximumQuantity;
    data['allowed_quantities'] = allowedQuantities;
    data['allow_adding_only_existing_attribute_combinations'] =
        allowAddingOnlyExistingAttributeCombinations;
    data['disable_buy_button'] = disableBuyButton;
    data['disable_wishlist_button'] = disableWishlistButton;
    data['available_for_pre_order'] = availableForPreOrder;
    data['pre_order_availability_start_date_time_utc'] =
        preOrderAvailabilityStartDateTimeUtc;
    data['call_for_price'] = callForPrice;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['product_cost'] = productCost;
    data['special_price'] = specialPrice;
    data['special_price_start_date_time_utc'] = specialPriceStartDateTimeUtc;
    data['special_price_end_date_time_utc'] = specialPriceEndDateTimeUtc;
    data['customer_enters_price'] = customerEntersPrice;
    data['minimum_customer_entered_price'] = minimumCustomerEnteredPrice;
    data['maximum_customer_entered_price'] = maximumCustomerEnteredPrice;
    data['baseprice_enabled'] = basepriceEnabled;
    data['baseprice_amount'] = basepriceAmount;
    data['baseprice_base_amount'] = basepriceBaseAmount;
    data['mark_as_new'] = markAsNew;
    data['mark_as_new_start_date_time_utc'] = markAsNewStartDateTimeUtc;
    data['mark_as_new_end_date_time_utc'] = markAsNewEndDateTimeUtc;
    data['has_tier_prices'] = hasTierPrices;
    data['has_discounts_applied'] = hasDiscountsApplied;
    data['weight'] = weight;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['available_start_date_time_utc'] = availableStartDateTimeUtc;
    data['available_end_date_time_utc'] = availableEndDateTimeUtc;
    data['display_order'] = displayOrder;
    data['published'] = published;
    data['deleted'] = deleted;
    data['created_on_utc'] = createdOnUtc;
    data['updated_on_utc'] = updatedOnUtc;
    data['product_type'] = productType;
    data['parent_grouped_product_id'] = parentGroupedProductId;
    if (roleIds != null) {
      data['role_ids'] = roleIds;
    }
    if (discountIds != null) {
      data['discount_ids'] = discountIds;
    }
    if (storeIds != null) {
      data['store_ids'] = storeIds;
    }
    data['manufacturer_ids'] = manufacturerIds;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (productAttributeCombinations != null) {
      data['product_attribute_combinations'] = productAttributeCombinations;
    }
    if (productSpecificationAttributes != null) {
      data['product_specification_attributes'] =
          productSpecificationAttributes!.map((v) => v.toJson()).toList();
    }
    data['associated_product_ids'] = associatedProductIds;
    data['tags'] = tags;
    data['vendor_id'] = vendorId;
    data['se_name'] = seName;
    data['id'] = id;
    return data;
  }
}

class Images {
  int? id;
  int? pictureId;
  int? position;
  String? src;
  var attachment;

  Images({this.id, this.pictureId, this.position, this.src, this.attachment});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pictureId = json['picture_id'];
    position = json['position'];
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['picture_id'] = pictureId;
    data['position'] = position;
    data['src'] = src;
    data['attachment'] = attachment;
    return data;
  }
}

class Attributes {
  int? productAttributeId;
  String? productAttributeName;
  String? textPrompt;
  bool? isRequired;
  int? attributeControlTypeId;
  int? displayOrder;
  var defaultValue;
  String? attributeControlTypeName;
  List<AttributeValues>? attributeValues;
  int? id;

  Attributes(
      {this.productAttributeId,
      this.productAttributeName,
      this.textPrompt,
      this.isRequired,
      this.attributeControlTypeId,
      this.displayOrder,
      this.defaultValue,
      this.attributeControlTypeName,
      this.attributeValues,
      this.id});

  Attributes.fromJson(Map<String, dynamic> json) {
    productAttributeId = json['product_attribute_id'];
    productAttributeName = json['product_attribute_name'];
    textPrompt = json['text_prompt'];
    isRequired = json['is_required'];
    attributeControlTypeId = json['attribute_control_type_id'];
    displayOrder = json['display_order'];
    defaultValue = json['default_value'];
    attributeControlTypeName = json['attribute_control_type_name'];
    if (json['attribute_values'] != null) {
      attributeValues = <AttributeValues>[];
      json['attribute_values'].forEach((v) {
        attributeValues!.add(AttributeValues.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_attribute_id'] = productAttributeId;
    data['product_attribute_name'] = productAttributeName;
    data['text_prompt'] = textPrompt;
    data['is_required'] = isRequired;
    data['attribute_control_type_id'] = attributeControlTypeId;
    data['display_order'] = displayOrder;
    data['default_value'] = defaultValue;
    data['attribute_control_type_name'] = attributeControlTypeName;
    if (attributeValues != null) {
      data['attribute_values'] =
          attributeValues!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class AttributeValues {
  int? typeId;
  int? associatedProductId;
  String? name;
  String? colorSquaresRgb;
  ImageSquaresImage? imageSquaresImage;
  double? priceAdjustment = 0;
  double? weightAdjustment = 0;
  double? cost = 0;
  int? quantity;
  bool? isPreSelected;
  int? displayOrder;
  var productImageId;
  String? type;
  int? id;

  AttributeValues(
      {this.typeId,
      this.associatedProductId,
      this.name,
      this.colorSquaresRgb,
      this.imageSquaresImage,
      this.priceAdjustment,
      this.weightAdjustment,
      this.cost,
      this.quantity,
      this.isPreSelected,
      this.displayOrder,
      this.productImageId,
      this.type,
      this.id});

  AttributeValues.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    associatedProductId = json['associated_product_id'];
    name = json['name'];
    colorSquaresRgb = json['color_squares_rgb'];
    imageSquaresImage = json['image_squares_image'] != null
        ? ImageSquaresImage.fromJson(json['image_squares_image'])
        : null;
    priceAdjustment = json['price_adjustment'];
    weightAdjustment = json['weight_adjustment'];
    cost = json['cost'];
    quantity = json['quantity'];
    isPreSelected = json['is_pre_selected'];
    displayOrder = json['display_order'];
    productImageId = json['product_image_id'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['associated_product_id'] = associatedProductId;
    data['name'] = name;
    data['color_squares_rgb'] = colorSquaresRgb;
    if (imageSquaresImage != null) {
      data['image_squares_image'] = imageSquaresImage!.toJson();
    }
    data['price_adjustment'] = priceAdjustment;
    data['weight_adjustment'] = weightAdjustment;
    data['cost'] = cost;
    data['quantity'] = quantity;
    data['is_pre_selected'] = isPreSelected;
    data['display_order'] = displayOrder;
    data['product_image_id'] = productImageId;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class ImageSquaresImage {
  String? src;
  var attachment;

  ImageSquaresImage({this.src, this.attachment});

  ImageSquaresImage.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['src'] = src;
    data['attachment'] = attachment;
    return data;
  }
}

class ProductSpecificationAttributes {
  int? productId;
  int? attributeTypeId;
  int? specificationAttributeOptionId;
  var customValue;
  bool? allowFiltering;
  bool? showOnProductPage;
  int? displayOrder;
  String? attributeType;
  var specificationAttributeOption;
  int? id;

  ProductSpecificationAttributes(
      {this.productId,
      this.attributeTypeId,
      this.specificationAttributeOptionId,
      this.customValue,
      this.allowFiltering,
      this.showOnProductPage,
      this.displayOrder,
      this.attributeType,
      this.specificationAttributeOption,
      this.id});

  ProductSpecificationAttributes.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    attributeTypeId = json['attribute_type_id'];
    specificationAttributeOptionId = json['specification_attribute_option_id'];
    customValue = json['custom_value'];
    allowFiltering = json['allow_filtering'];
    showOnProductPage = json['show_on_product_page'];
    displayOrder = json['display_order'];
    attributeType = json['attribute_type'];
    specificationAttributeOption = json['specification_attribute_option'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['attribute_type_id'] = attributeTypeId;
    data['specification_attribute_option_id'] = specificationAttributeOptionId;
    data['custom_value'] = customValue;
    data['allow_filtering'] = allowFiltering;
    data['show_on_product_page'] = showOnProductPage;
    data['display_order'] = displayOrder;
    data['attribute_type'] = attributeType;
    data['specification_attribute_option'] = specificationAttributeOption;
    data['id'] = id;
    return data;
  }
}
