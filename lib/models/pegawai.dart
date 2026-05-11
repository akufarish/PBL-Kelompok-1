class PegawaiResponse {
  final int id;
  final String nip;
  final String nik;
  final String employeeName;
  final String? address;
  final String? birthPlace;
  final String? birthDate;
  final String? gender;
  final String? phoneNumber;
  final String? villageCode;
  final String? districtCode;
  final String? cityCode;
  final String? provinceCode;
  final String? village;
  final String? district;
  final String? city;
  final String? province;

  PegawaiResponse({
    required this.id,
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.address,
    required this.birthDate,
    required this.birthPlace,
    required this.gender,
    required this.phoneNumber,
    required this.village,
    required this.villageCode,
    required this.district,
    required this.districtCode,
    required this.city,
    required this.cityCode,
    required this.province,
    required this.provinceCode,
  });

  factory PegawaiResponse.fromJson(Map<String, dynamic> json) {
    return PegawaiResponse(
      id: json["id"],
      nip: json["nip"],
      address: json["address"],
      birthDate: json["birth_date"],
      birthPlace: json["birth_place"],
      city: json["city"],
      cityCode: json["city_code"],
      district: json["district"],
      gender: json["gender"],
      nik: json["nik"],
      province: json["province"],
      village: json["village"],
      districtCode: json["district_code"],
      employeeName: json["employee_name"],
      phoneNumber: json["phone_number"],
      provinceCode: json["province_code"],
      villageCode: json["village_code"],
    );
  }
}

class PegawaiRequest {
  final String nip;
  final String nik;
  final String employeeName;
  final String citizenCode;

  PegawaiRequest({
    required this.nip,
    required this.nik,
    required this.employeeName,
    required this.citizenCode,
  });

  factory PegawaiRequest.fromJson(Map<String, dynamic> json) {
    return PegawaiRequest(
      nik: json["nik"],
      nip: json["nip"],
      citizenCode: json["citizen_code"],
      employeeName: json["employee_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "nik": nik,
    "nip": nip,
    "citizen_code": citizenCode,
    "employee_name": employeeName,
  };
}
