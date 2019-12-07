/// goodsId : "2171c20d77c340729d5d7ebc2039c08d"
/// goodsName : "五粮液52°500ml"
/// count : 1
/// price : 830.0
/// image : "http://images.baixingliangfan.cn/shopGoodsImg/20181229/20181229211422_8507.jpg"

class CartInfo {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String image;
  bool isCheck;

  static CartInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CartInfo cartInfoBean = CartInfo();
    cartInfoBean.goodsId = map['goodsId'];
    cartInfoBean.goodsName = map['goodsName'];
    cartInfoBean.count = map['count'];
    cartInfoBean.price = map['price'];
    cartInfoBean.image = map['image'];
    cartInfoBean.isCheck = map['isCheck'];
    return cartInfoBean;
  }

  Map toJson() => {
    "goodsId": goodsId,
    "goodsName": goodsName,
    "count": count,
    "price": price,
    "image": image,
    "isCheck": isCheck,
  };
}