import 'dart:convert';

class OffersList {
  final List<JobOfferModel> data;

  OffersList(this.data);

  factory OffersList.fromJson(dynamic json) {
    List<JobOfferModel> dataList = [];
    if (json != null && json.isNotEmpty) {
      json.forEach((element) {
        dataList.add(JobOfferModel.fromMap(element));
      });
    }

    return OffersList(dataList);
  }
}

class JobOfferModel {
  String offerId;
  String offererId;
  double budget;
  int deliveryTime;
  String description;
  String? attachment;
  DateTime offerDate;
  String? status;

  JobOfferModel({
    required this.offerId,
    required this.offererId,
    required this.budget,
    required this.deliveryTime,
    required this.description,
    this.attachment = '',
    required this.offerDate,
    this.status,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'offerId': offerId});
    result.addAll({'offererId': offererId});
    result.addAll({'budget': budget});
    result.addAll({'deliveryTime': deliveryTime});
    result.addAll({'description': description});
    result.addAll({'attachment': attachment});
    result.addAll({'offerDate': offerDate.millisecondsSinceEpoch});
    result.addAll({'status': status ?? ''});
    return result;
  }

  factory JobOfferModel.fromMap(Map<String, dynamic> map) {
    return JobOfferModel(
      offerId: map['offerId'] ?? '',
      offererId: map['offererId'] ?? '',
      budget: double.parse(map['budget'].toString()),
      deliveryTime: map['deliveryTime'] ?? -1,
      description: map['description'] ?? '',
      attachment: map['attachment'] ?? '',
      offerDate: map['offerDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['offerDate'])
          : DateTime.now(),
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobOfferModel.fromJson(String source) =>
      JobOfferModel.fromMap(json.decode(source));
}
