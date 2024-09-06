class ListuserModel {
  String? rowPointer;
  String? id;
  String? no;
  String? name;
  String? password;
  int? superUserFlag;
  String? companyNo;
  String? menuHeaderNo;
  int? status;
  int? isNotRestrictProject;
  DateTime? createdDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;
  String? site;
  String? groupSiteID;
  String? companyCode;
  String? conn;
  int? isUpdate;
  String? jwTtoken;
  String? secret;
  String? versionInfoCurrent;
  String? machineName;
  String? saltValue;
  String? enValue;
  String? emailAddress;
  String? passwordApplication;

  ListuserModel({
    this.rowPointer,
    this.id,
    this.no,
    this.name,
    this.password,
    this.superUserFlag,
    this.companyNo,
    this.menuHeaderNo,
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
    this.secret,
    this.versionInfoCurrent,
    this.machineName,
    this.saltValue,
    this.enValue,
    this.emailAddress,
    this.passwordApplication,
  });

  // Tạo phương thức từ JSON
  factory ListuserModel.fromJson(Map<String, dynamic> json) {
    return ListuserModel(
      rowPointer: json['rowPointer'],
      id: json['id'],
      no: json['no_'],
      name: json['name'],
      password: json['password'],
      superUserFlag: json['superUserFlag'],
      companyNo: json['companyNo_'],
      menuHeaderNo: json['menuHeaderNo_'],
      status: json['status'],
      isNotRestrictProject: json['isNotRestrictProject'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      createdBy: json['createdBy'],
      updatedDate: json['updatedDate'] != null
          ? DateTime.parse(json['updatedDate'])
          : null,
      updatedBy: json['updatedBy'],
      site: json['site'],
      groupSiteID: json['groupSiteID'],
      companyCode: json['companyCode'],
      conn: json['conn'],
      isUpdate: json['isUpdate'],
      jwTtoken: json['jwTtoken'],
      secret: json['secret'],
      versionInfoCurrent: json['versionInfoCurrent'],
      machineName: json['machineName'],
      saltValue: json['saltValue'],
      enValue: json['enValue'],
      emailAddress: json['emailAddress'],
      passwordApplication: json['passwordApplication'],
    );
  }

  // Chuyển thành JSON
  Map<String, dynamic> toJson() {
    return {
      'rowPointer': rowPointer,
      'id': id,
      'no_': no,
      'name': name,
      'password': password,
      'superUserFlag': superUserFlag,
      'companyNo_': companyNo,
      'menuHeaderNo_': menuHeaderNo,
      'status': status,
      'isNotRestrictProject': isNotRestrictProject,
      'createdDate': createdDate?.toIso8601String(),
      'createdBy': createdBy,
      'updatedDate': updatedDate?.toIso8601String(),
      'updatedBy': updatedBy,
      'site': site,
      'groupSiteID': groupSiteID,
      'companyCode': companyCode,
      'conn': conn,
      'isUpdate': isUpdate,
      'jwTtoken': jwTtoken,
      'secret': secret,
      'versionInfoCurrent': versionInfoCurrent,
      'machineName': machineName,
      'saltValue': saltValue,
      'enValue': enValue,
      'emailAddress': emailAddress,
      'passwordApplication': passwordApplication,
    };
  }
}
