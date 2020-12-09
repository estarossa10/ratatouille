class Users {
  String UserID, Email, Username, Name, Phone, Address, LastLogin;

  Users({this.UserID, this.Username, this.Email, this.Name, this.Phone, this.Address, this.LastLogin});

  String get userId => UserID;
  String get email => Email;
  String get username => Username;
  String get name => Name;
  String get phone => Phone;
  String get address => Address;
  String get lastLogin => LastLogin;

  Users.map(dynamic obj) {
    this.UserID = obj['UserID'];
    this.Email = obj['Email'];
    this.Username = obj['Username'];
    this.Name = obj['Name'];
    this.Phone = obj['Phone'];
    this.Address = obj['Address'];
    this.LastLogin = obj['LastLogin'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['UserID'] = UserID;
    map['Email'] = Email;
    map['Username'] = Username;
    map['Name'] = Name;
    map['Phone'] = Phone;
    map['Address'] = Address;
    map['LastLogin'] = LastLogin;
  }

}