// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

List<UserResponse> userResponseFromJson(String str) => List<UserResponse>.from(
    json.decode(str).map((x) => UserResponse.fromJson(x)));

String userResponseToJson(List<UserResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponse {
  int id;
  String name;
  String username;
  String email;
  Address address;

  UserResponse({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
      };
}

class Address {
  String street;
  String city;
  String state;
  String zipcode;

  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "zipcode": zipcode,
      };
}
