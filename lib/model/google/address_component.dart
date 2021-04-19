import 'package:json_annotation/json_annotation.dart';
part 'address_component.g.dart';

@JsonSerializable()
class AddressComponent {
  String formatted_address;
  List<Address> address_components;
  AddressComponent();
  factory AddressComponent.fromJson(Map<String,dynamic>json)=>_$AddressComponentFromJson(json);
}

@JsonSerializable()
class Address {
  String short_name;
  List<String> types;
  Address();
  factory Address.fromJson(Map<String,dynamic>json)=>_$AddressFromJson(json);
}

