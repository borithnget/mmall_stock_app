import 'package:http/http.dart';

class Api {
  static String mainUrl = 'http://49.156.39.97:12220/api/';
  static String imageMainUrl='http://49.156.39.97:12338/';
  static String dashboardSaleLast10 = 'Dashboard/SaleLatest10';

  static String urlBanner() {
    // return '${Api.mainUrl1}${Api.subBanner}';
  }
}

///Function
class Func {
  Client client = Client();

  ///productById
  // Future<BuiltList<Product>> getProduct(String productId) async {
  //   Map<String, dynamic> body = {
  //     'product_id': productId,
  //   };
  //   // print('$tag $url');
  //   final response =
  //       await client.post(Api.mainUrl1 + Api.productById, body: body);
  //
  //   if (response.statusCode == HttpStatus.ok) {
  //     // If the call to the server was successful, parse the JSON
  //     final ProductResponse results = ProductResponse.fromJson(response.body);
  //     return results.product;
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Error al cargar los datos');
  //   }
  // }
}
