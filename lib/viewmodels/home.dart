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
