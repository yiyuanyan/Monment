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
  List<IconList> iconList;

  BottomIconsModel({this.statusCode, this.message, this.iconList});

  BottomIconsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['icon_list'] != null) {
      iconList = new List<IconList>();
      json['icon_list'].forEach((v) {
        iconList.add(new IconList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.iconList != null) {
      data['icon_list'] = this.iconList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IconList {
  int id;
  String icon;
  int sort;

  IconList({this.id, this.icon, this.sort});

  IconList.fromJson(Map<String, dynamic> json) {
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
