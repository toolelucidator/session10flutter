class Student {
  int? controlnum;
  String? name;
  String? apepa;
  String? apema;
  String? tel;
  String? email;

  Student(
      this.controlnum, this.name, this.apepa, this.apema, this.tel, this.email);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'controlnum': controlnum,
      'name': name,
      'apepa': apepa,
      'apema': apema,
      'tel': tel,
      'email': email,
    };

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    controlnum = map['controlnum'];
    name = map['name'];
    apepa = map['apepa'];
    apema = map['apema'];
    tel = map['tel'];
    email = map['email'];
  }
}
