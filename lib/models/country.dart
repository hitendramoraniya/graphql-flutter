class Country {
  final String? name;
  final String? phone;
  final String? capital;
  final String? emoji;
  final String? currency;
  final String? code;

  Country({required this.name, required this.phone,required this.capital, required this.emoji, required this.currency,required this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? "",
      phone: json['phone'] ?? "",
      capital: json['capital'] ?? "",
      emoji: json['emoji'] ?? "",
      currency: json['currency'] ?? "",
      code: json['code'] ?? "",
    );
  }
}
