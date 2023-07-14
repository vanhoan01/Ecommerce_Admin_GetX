import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_getx/models/models.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<OrderStats>> getOrderStats() {
    return _firebaseFirestore
        .collection('order_stats')
        .orderBy('dateTime')
        .get()
        .then((querySnapshot) => querySnapshot.docs
            .asMap()
            .entries
            .map((entry) => OrderStats.fromSnapshot(entry.value, entry.key))
            .toList());
  }

  Stream<List<OrderModel>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<OrderModel>> getPendingOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    });
  }

  Stream<List<Product>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
    Product product,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('products')
        .doc(product.id)
        .update({field: newValue}) // <-- Updated data
        // ignore: avoid_print
        .then((_) => print('Success'))
        // ignore: avoid_print
        .catchError((error) => print('Failed: $error'));
  }

  Future<void> updateOrder(
    OrderModel order,
    String field,
    dynamic newValue,
  ) {
    return _firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        // <-- Updated data
        // ignore: avoid_print
        .then((query) => {
              query.docs.first.reference.update({field: newValue})
            });
  }
}
