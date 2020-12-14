class Employee {
  int _id;

  String _name;
  String _designation;
  String _department;
  String _contactOff;
  String _contactMob;
  String _email;
  String _location;
  String _field;

  Employee(this._name, this._designation, this._department, this._contactOff,
      this._contactMob, this._email, this._location, this._field);
  Employee.withId(this._id, this._name, this._designation, this._department, this._contactOff,
      this._contactMob, this._email, this._location, this._field);

  String get field => _field;

  String get location => _location;

  String get email => _email;

  String get contactMob => _contactMob;

  String get contactOff => _contactOff;

  String get department => _department;

  String get designation => _designation;

  String get name => _name;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(_id != null)
      map['id'] = _id;

    map['name'] = _name;
    map['designation'] = _designation;
    map['department'] = _department;
    map['contact_office'] = _contactOff;
    map['contact_mobile'] = _contactMob;
    map['email'] = _email;
    map['location'] = _location;
    map['field'] = _field;

    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._designation = map['designation'];
    this._contactOff = map['contact_office'];
    this._contactMob = map['contact_mobile'];
    this._email = map['email'];
    this._location = map['location'];
    this._field = map['field'];
  }
}