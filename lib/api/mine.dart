import 'package:hm_shop/contants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<SpecialOfferGoodsDetailsItems> getGuesssListAPI(
  Map<String, dynamic> params,
) async {
  return SpecialOfferGoodsDetailsItems.fromJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
