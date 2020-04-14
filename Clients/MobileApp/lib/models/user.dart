class User {
  int id;
  String email;
  String password;
  String name;
  String country;
  String dguNumber;
  double handicap;
  List<int> bufferZone;

  User(
      {int id,
      String email,
      String password,
      String name,
      String country,
      String dguNumber,
      double handicap,
      List<int> bufferZone})
      : this.id = id ?? -1,
        this.email = email ?? '',
        this.password = password ?? '',
        this.name = name = '',
        this.country = country ?? '',
        this.dguNumber = dguNumber ?? '',
        this.handicap = handicap ?? 0.0,
        this.bufferZone = bufferZone ?? [0, 22];

  String bufferZoneString() {
    String returnString = '';

    if (bufferZone == null) {
      return 'null';
    }

    bufferZone.forEach((bufferZoneNumber) {
      int numberInList = bufferZone.indexOf(bufferZoneNumber);

      if (numberInList == bufferZone.length - 1) {
        returnString += '$bufferZoneNumber';
      } else {
        returnString += '$bufferZoneNumber-';
      }
    });

    return returnString;
  }

  User.publicUser(
      {this.id, this.name, this.handicap, this.country, this.bufferZone});

  @override
  String toString() {
    return "${this.id}: [name: ${this.name}, email: ${this.email}, country: ${this.country}, dguNumber: ${this.dguNumber}, handicap: ${this.handicap}, bufferzone: ${this.bufferZoneString()}]";
  }
}
