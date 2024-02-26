class alpha {
  String? alphaTwoCode;
  // Null? stateProvince;
  List<String>? domains;
  String? name;
  List<String>? webPages;
  String? country;

  alpha(
      {this.alphaTwoCode,
        // this.stateProvince,
        this.domains,
        this.name,
        this.webPages,
        this.country});

  alpha.fromJson(Map<String, dynamic> json) {
    alphaTwoCode = json['alpha_two_code'];
    // stateProvince = json['state-province'];
    domains = json['domains'].cast<String>();
    name = json['name'];
    webPages = json['web_pages'].cast<String>();
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alpha_two_code'] = this.alphaTwoCode;
    // data['state-province'] = this.stateProvince;
    data['domains'] = this.domains;
    data['name'] = this.name;
    data['web_pages'] = this.webPages;
    data['country'] = this.country;
    return data;
  }
}
