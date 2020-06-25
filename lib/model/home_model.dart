class BannerModel {
  int statusCode;
  String message;
  List<Swipers> swipers;

  BannerModel({this.statusCode, this.message, this.swipers});

  BannerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['swipers'] != null) {
      swipers = new List<Swipers>();
      json['swipers'].forEach((v) {
        swipers.add(new Swipers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.swipers != null) {
      data['swipers'] = this.swipers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Swipers {
  int id;
  String banner;
  int sort;

  Swipers({this.id, this.banner, this.sort});

  Swipers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['sort'] = this.sort;
    return data;
  }
}

class BottomIconsModel {
  int statusCode;
  String message;
  List<Icons> icons;

  BottomIconsModel({this.statusCode, this.message, this.icons});

  BottomIconsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['icons'] != null) {
      icons = new List<Icons>();
      json['icons'].forEach((v) {
        icons.add(new Icons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.icons != null) {
      data['icons'] = this.icons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Icons {
  int id;
  String icon;
  int sort;

  Icons({this.id, this.icon, this.sort});

  Icons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['sort'] = this.sort;
    return data;
  }
}
