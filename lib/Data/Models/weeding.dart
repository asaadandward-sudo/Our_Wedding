class Wedding {
  final String groomName;
  final String brideName;
  final String groomEmail;
  final String brideEmail;
  final String day;
  final String date;
  final String time;
  final String quote;
  final String church;
  final String city;
  final String state;
  final String locationDetails;
  final String mapLink;
  final String calendarDate;
  final String details;
  final String logo;

  const Wedding({
    required this.groomName,
    required this.brideName,
    required this.groomEmail,
    required this.brideEmail,
    required this.day,
    required this.date,
    required this.time,
    required this.quote,
    required this.church,
    required this.city,
    required this.state,
    required this.locationDetails,
    required this.mapLink,
    required this.calendarDate,
    required this.details,
    required this.logo,
  });

  Map<String, dynamic> toMap() => {
        'groomName': groomName,
        'brideName': brideName,
        'groomEmail': groomEmail,
        'brideEmail': brideEmail,
        'day': day,
        'date': date,
        'time': time,
        'quote': quote,
        'church': church,
        'city': city,
        'state': state,
        'locationDetails': locationDetails,
        'mapLink': mapLink,
        'calendarDate': calendarDate,
        'details': details,
        'logo': logo,
      };

  factory Wedding.fromMap(Map<String, dynamic> map) => Wedding(
        groomName: map['groomName'] ?? '',
        brideName: map['brideName'] ?? '',
        groomEmail: map['groomEmail'] ?? '',
        brideEmail: map['brideEmail'] ?? '',
        day: map['day'] ?? '',
        date: map['date'] ?? '',
        time: map['time'] ?? '',
        quote: map['quote'] ?? '',
        church: map['church'] ?? '',
        city: map['city'] ?? '',
        state: map['state'] ?? '',
        locationDetails: map['locationDetails'] ?? '',
        mapLink: map['mapLink'] ?? '',
        calendarDate: map['calendarDate'] ?? '',
        details: map['details'] ?? '',
        logo: map['logo'] ?? '',
      );
}
