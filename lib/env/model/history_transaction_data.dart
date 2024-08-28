import 'package:equatable/equatable.dart';

class HistoryTransactionData extends Equatable {
  const HistoryTransactionData({
    required this.receiveNumber,
    required this.category,
    required this.name,
    required this.icon,
  });

  final String receiveNumber;
  final String category;
  final String name;
  final String icon;

  factory HistoryTransactionData.fromJson(Map<String, dynamic> json) {
    return HistoryTransactionData(
      receiveNumber: json["receive_number"] ?? "",
      category: json["category"] ?? "",
      name: json["name"] ?? "",
      icon: json["icon"] ?? "",
    );
  }

  @override
  List<Object?> get props => [receiveNumber, category, name, icon];
}

/*
{
	"receive_number": "089639612828",
	"category": "DATA",
	"name": "DATA THREE",
	"icon": "https://via.placeholder.com/150"
}*/