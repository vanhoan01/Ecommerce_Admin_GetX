import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double deliveryFee;
  final double total;
  final bool isAccepted;
  final bool isCancelled;
  final bool isDelivered;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.deliveryFee,
    required this.total,
    required this.isAccepted,
    required this.isCancelled,
    required this.isDelivered,
    required this.createdAt,
  });

  @override
  List<Object> get props {
    return [
      id,
      customerId,
      productIds,
      deliveryFee,
      // subtotal,
      total,
      isAccepted,
      isDelivered,
      isCancelled,
      createdAt,
    ];
  }

  OrderModel copyWith({
    int? id,
    int? customerId,
    List<int>? productIds,
    double? deliveryFee,
    double? subtotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      // subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'deliveryFee': deliveryFee,
      // 'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      id: snap['id'],
      customerId: snap['customerId'],
      productIds: List<int>.from(snap['productIds']),
      deliveryFee: snap['deliveryFee'],
      // subtotal: snap['subtotal'],
      total: snap['total'],
      isAccepted: snap['isAccepted'],
      isDelivered: snap['isDelivered'],
      isCancelled: snap['isCancelled'],
      createdAt: snap['createdAt'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  static List<OrderModel> orders = [
    OrderModel(
      id: 1,
      customerId: 2345,
      productIds: const [1, 2],
      deliveryFee: 10,
      // subtotal: 20,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    OrderModel(
      id: 2,
      customerId: 23,
      productIds: const [1, 2, 3],
      deliveryFee: 10,
      // subtotal: 30,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
  ];
}
