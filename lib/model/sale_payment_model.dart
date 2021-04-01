import 'dart:convert';

String putSalePaymentToJson(PutSalePayment data)
{
  final dyn=data.toJson();
  return json.encode(dyn);
}

class PutSalePayment{
  double ReceivedUSD;
  double ReceivedReal;
  double AmountAdjustmentUSD;
  double AmountAdjustmentReal;
  bool IsAmountAdjustment;
  String UserId;

  PutSalePayment( {
    this.ReceivedUSD,
    this.ReceivedReal,
    this.AmountAdjustmentUSD,
    this.AmountAdjustmentReal,
    this.IsAmountAdjustment,
    this.UserId
});

  factory PutSalePayment.formJson(Map<String,dynamic> json)=>new PutSalePayment(
    ReceivedReal: json["ReceivedReal"],
    ReceivedUSD: json["ReceivedUSD"],
    AmountAdjustmentUSD: json["AmountAdjustmentUSD"],
    AmountAdjustmentReal: json["AmountAdjustmentReal"],
    IsAmountAdjustment: json["IsAmountAdjustment"],
    UserId: json["UserId"]

  );

  Map<String,dynamic> toJson()=>{
    "ReceivedReal":ReceivedReal,
    "ReceivedUSD":ReceivedUSD,
    "AmountAdjustmentUSD":AmountAdjustmentUSD,
    "AmountAdjustmentReal":AmountAdjustmentReal,
    "IsAmountAdjustment":IsAmountAdjustment,
    "UserId":UserId
  };

}