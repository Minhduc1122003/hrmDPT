import 'dart:convert';

class LoginModel {
  final String? rowPointer;
  final String? id;
  final String? no_;
  final String? name;
  final String? password;
  final int? superUserFlag;
  final String? companyNo_;
  final String? menuHeaderNo_;
  final int? status;
  final int? isNotRestrictProject;
  final String? createdDate;
  final String? createdBy;
  final String? updatedDate;
  final String? updatedBy;
  final String? site;
  final String? groupSiteID;
  final String? companyCode;
  final String? conn;
  final int? isUpdate;
  final String? jwTtoken;

  LoginModel({
    this.rowPointer,
    this.id,
    this.no_,
    this.name,
    this.password,
    this.superUserFlag,
    this.companyNo_,
    this.menuHeaderNo_,
    this.status,
    this.isNotRestrictProject,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.site,
    this.groupSiteID,
    this.companyCode,
    this.conn,
    this.isUpdate,
    this.jwTtoken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      rowPointer: json['rowPointer'],
      id: json['id'],
      no_: json['no_'],
      name: json['name'],
      password: json['password'],
      superUserFlag: json['superUserFlag'],
      companyNo_: json['companyNo_'],
      menuHeaderNo_: json['menuHeaderNo_'],
      status: json['status'],
      isNotRestrictProject: json['isNotRestrictProject'],
      createdDate: json['createdDate'],
      createdBy: json['createdBy'],
      updatedDate: json['updatedDate'],
      updatedBy: json['updatedBy'],
      site: json['site'],
      groupSiteID: json['groupSiteID'],
      companyCode: json['companyCode'],
      conn: json['conn'],
      isUpdate: json['isUpdate'],
      jwTtoken: json['jwTtoken'],
    );
  }
}

class User {
  static String no_ = "";
  static String name = "";
  static String site = "";
  static String token = "";
  static String company = "";
}
