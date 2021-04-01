
import 'package:markarian_sales/model/commom_model.dart';
import 'package:markarian_sales/model/sale_latest_10_model.dart';

class CommomFunctions{

  static Sale ConvertSaleModelToSale(SaleModel _sale){
    Sale sale=Sale();
    sale.totalOutstandingUSD=_sale.totalOutstandingUSD;
    sale.totalOutstandingKHR=_sale.totalOutstandingKHR;
    sale.totalAmount=_sale.totalAmount;
    sale.totalAmountKHR=_sale.totalAmountKHR;
    sale.id=_sale.id;
    sale.saleNumber=_sale.saleNumber;

    return sale;
  }

}
