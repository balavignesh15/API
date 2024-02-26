class bored {
  String? message;
  String? status;
  // int? participants;
  // double? price;
  // String? link;
  // String? key;
  // double? accessibility;

  bored(
      {
    this.message,
        this.status
        // this.activity,
        // this.type,
        // this.participants,
        // this.price,
        // this.link,
        // this.key,
        // this.accessibility
      });

  bored.fromJson(Map<String, dynamic> json) {
    message=json['message'];
    status=json['status'];

    // activity = json['activity'];
    // type = json['type'];
    // participants = json['participants'];
    // price = json['price'];
    // link = json['link'];
    // key = json['key'];
    // accessibility = json['accessibility'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    data['status'] = this.status;
    // data['activity'] = this.activity;
    // data['type'] = this.type;
    // data['participants'] = this.participants;
    // data['price'] = this.price;
    // data['link'] = this.link;
    // data['key'] = this.key;
    // data['accessibility'] = this.accessibility;
    return data;
  }
}
