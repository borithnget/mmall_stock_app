import 'dart:convert';

String loginToJson(Login data){
  final dyn=data.toJson();
  return json.encode(dyn);
}

LoginResult loginResultFromJson(String str){
  final jsonData=json.decode(str);
  return LoginResult.fromJson(jsonData);
}

class Login{
  String Username;
  String Password;

  Login({
    this.Username,
    this.Password
});

  factory Login.formJson(Map<String,dynamic> json)=>new Login(
    Username: json["Username"],
    Password: json["Password"],
  );

  Map<String,dynamic> toJson()=>{
    "Username":Username,
    "Password":Password
  };

}

class LoginResult{
  String token;
  String id;
  //String username;

  LoginResult({
   this.token,
   this.id,
    //this.username,
});

  factory LoginResult.fromJson(Map<String,dynamic> json)=>LoginResult(
    token: json["token"],
    id: json["id"],
    //username: json["username"]
  );

  Map<String,dynamic> toJson()=>{
    "token":token,
    "id":id,

  };

}