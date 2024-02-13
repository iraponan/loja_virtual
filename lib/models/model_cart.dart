import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/model_user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loja_virtual/datas/data_cart_product.dart';

class CartModel extends Model {
  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItens();
    }
  }

  UserModel user;

  List<CartProduct> products = [];

  bool isLoading = false;

  String? couponCode;
  int? discountPercentage;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
    });
    notifyListeners();
  }

  void removeCarItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity = cartProduct.quantity! - 1;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity = cartProduct.quantity! + 1;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  Future<void> _loadCartItens() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('cart')
        .get();
    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) {
        price += (c.quantity! * c.productData!.price!);
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductPrice() * (discountPercentage ?? 0.00) / 100.0;
  }

  double getShipPrice() {
    return 5.00;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String?> finishOrder() async {
    if (products.isEmpty) return null;
    isLoading = true;
    notifyListeners();

    double productsPrice = getProductPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection('orders').add({
      'clientId': user.firebaseUser?.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discount,
      'totalPrice': (productsPrice - discount + shipPrice),
      'status': 1
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.firebaseUser?.uid)
        .collection('orders')
        .doc(refOrder.id)
        .set({'orderId': refOrder.id});

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.firebaseUser?.uid).collection('cart').get();

    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }
    products.clear();
    discountPercentage = 0;
    couponCode = null;
    isLoading = false;
    notifyListeners();

    return refOrder.id;
  }
}
