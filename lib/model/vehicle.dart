class Vehicle {
  String policyNumber;
  String date;
  String duration;
  int point;

  Vehicle({
    required this.policyNumber,
    required this.date,
    required this.duration,
    required this.point
  });
}

var vehicles = [
  Vehicle(policyNumber: 'B 1235 JK', date: '19 Juli 2021', duration: '15 menit', point: 100),
  Vehicle(policyNumber: 'B 1235 JK', date: '19 Juli 2021', duration: '15 menit', point: 100),
  Vehicle(policyNumber: 'B 1235 JK', date: '19 Juli 2021', duration: '15 menit', point: 100),
  Vehicle(policyNumber: 'B 1235 JK', date: '19 Juli 2021', duration: '15 menit', point: 100)
];
