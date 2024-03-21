class OrderStatus {
  OrderStatus({this.link, this.remains, this.status, this.startCount});

  String? startCount;
  String? status;
  String? remains;
  String? link;

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
        link: json['link'],
        remains: json['remains'],
        status: json['status'],
        startCount: json['start_count']);
  }
  Map<String, dynamic> toJson() {
    return {
      'link': link,
      'status': status,
      'start_count': startCount,
      'remains': remains,
    };
  }
}
