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

class ContentListsModel {
  int statusCode;
  String message;
  List<ContentLists> contentLists;

  ContentListsModel({this.statusCode, this.message, this.contentLists});

  ContentListsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['content_lists'] != null) {
      contentLists = new List<ContentLists>();
      json['content_lists'].forEach((v) {
        contentLists.add(new ContentLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.contentLists != null) {
      data['content_lists'] = this.contentLists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentLists {
  int id;
  String image;
  String playTime;
  String portrait;
  String title;
  String tag;

  ContentLists(
      {this.id,
        this.image,
        this.playTime,
        this.portrait,
        this.title,
        this.tag});

  ContentLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    playTime = json['play_time'];
    portrait = json['portrait'];
    title = json['title'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['play_time'] = this.playTime;
    data['portrait'] = this.portrait;
    data['title'] = this.title;
    data['tag'] = this.tag;
    return data;
  }
}
