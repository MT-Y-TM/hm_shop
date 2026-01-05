class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  //使用一个factory函数用来创建一个实例对象
  // flutter必须强制转换
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "imgUrl");
  }
}

//根据json编写class对象和工厂转化函数，忽略goods字段
//分类列表
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    required this.children,
  });
  factory CategoryItem.fromJSON(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      picture: json['picture'] ?? "",
      children: json['children'] == null
          ? null
          : (json['children'] as List).map((item) {
              return CategoryItem.fromJSON(item as Map<String, dynamic>);
            }).toList(),
    );
  }
}


class SpecialOfferResult {
  String id;
  String title;
  List<SpecialOfferSubType> subTypes;

  SpecialOfferResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialOfferResult.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferResult(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      subTypes: (json['subTypes'] as List)
          .map((item) => SpecialOfferSubType.fromJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SpecialOfferSubType {
  String id;
  String title;
  SpecialOfferGoodsItems goodsItems;

  SpecialOfferSubType({
    required this.id,
    required this.title,
    required this.goodsItems,
  });

  factory SpecialOfferSubType.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferSubType(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      goodsItems: SpecialOfferGoodsItems.fromJSON(json['goodsItems'] as Map<String, dynamic>),
    );
  }
}

class SpecialOfferGoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<SpecialOfferGoodsItem> items;

  SpecialOfferGoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialOfferGoodsItems.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferGoodsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List)
          .map((item) => SpecialOfferGoodsItem.fromJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SpecialOfferGoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodDetailItem> items;

  SpecialOfferGoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory SpecialOfferGoodsDetailsItems.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferGoodsDetailsItems(
      counts: json['counts'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      pages: json['pages'] ?? 0,
      page: json['page'] ?? 0,
      items: (json['items'] as List)
          .map((item) => GoodDetailItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SpecialOfferGoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;

  SpecialOfferGoodsItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory SpecialOfferGoodsItem.fromJSON(Map<String, dynamic> json) {
    return SpecialOfferGoodsItem(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      desc: json['desc'],
      price: json['price'] ?? "",
      picture: json['picture'] ?? "",
      orderNum: json['orderNum'] ?? 0,
    );
  }
}



class GoodDetailItem extends SpecialOfferGoodsItem {
  int payCount = 0;

  /// 商品详情项
  GoodDetailItem({
    required super.id,
    required super.name,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  // 转化方法
  factory GoodDetailItem.formJSON(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}
