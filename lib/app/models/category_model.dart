class CategoryModel {
  String? name;
  String? description;
  int? categoryTemplateId;
  int? parentCategoryId;
  int? pageSize;
  List<int>? pageSizeOptions;
  bool? includeInTopMenu;
  bool? published;
  bool? deleted;
  int? displayOrder;
  String? createdOnUtc;
  String? updatedOnUtc;
  ImageData? image;
  String? seName;
  int? id;

  CategoryModel({
    this.name,
    this.description,
    this.categoryTemplateId,
    this.parentCategoryId,
    this.pageSize,
    this.pageSizeOptions,
    this.includeInTopMenu,
    this.published,
    this.deleted,
    this.displayOrder,
    this.createdOnUtc,
    this.updatedOnUtc,
    this.image,
    this.seName,
    this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      description: json['description'],
      categoryTemplateId: json['category_template_id'],
      parentCategoryId: json['parent_category_id'],
      pageSize: json['page_size'],
      pageSizeOptions: (json['page_size_options'] as String)
          .split(',')
          .map((e) => int.tryParse(e) ?? 0)
          .toList(),
      includeInTopMenu: json['include_in_top_menu'],
      published: json['published'],
      deleted: json['deleted'],
      displayOrder: json['display_order'],
      createdOnUtc: json['created_on_utc'],
      updatedOnUtc: json['updated_on_utc'],
      image: ImageData.fromJson(json['image']),
      seName: json['se_name'],
      id: json['id'],
    );
  }
}

class ImageData {
  String src;
  String? attachment;

  ImageData({
    required this.src,
    this.attachment,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      src: json['src'],
      attachment: json['attachment'],
    );
  }
}
