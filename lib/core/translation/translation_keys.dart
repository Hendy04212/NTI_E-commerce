import 'package:flutter/material.dart';

import '../cache/cache_keys.dart';

abstract class TranslationKeys {
  static const Locale localeEN = Locale(CacheKeys.keyEN);
  static const Locale localeAR = Locale(CacheKeys.keyAR);

  // Auth
  static const welcomeBack = "welcomeBack";
  static const createAccount = "createAccount";
  static const login = "login";
  static const register = "Register";
  static const email = "email";
  static const password = "password";
  static const confirmPassword = "confirmPassword";
  static const fullName = "fullName";
  static const phone = "phone";
  static const agreeTerms = "agreeTerms";
  static const registrationSuccessful = "registrationSuccessful";

  // Home
  static const allFeatured = "allFeatured";
  static const recommended = "recommended";
  static const searchHint = "searchHint";

  // Cart
  static const cart = "cart";
  static const shoppingList = "shoppingList";
  static const subtotal = "subtotal";
  static const taxAndFees = "taxAndFees";
  static const deliveryFee = "deliveryFee";
  static const orderTotal = "orderTotal";
  static const checkout = "checkout";
  static const addToCart = "addToCart";
  static const yourCartIsEmpty = "yourCartIsEmpty";

  // Checkout
  static const deliveryAddress = "deliveryAddress";
  static const addressHint = "addressHint";
  static const placeOrder = "placeOrder";
  static const noItemsToCheckout = "noItemsToCheckout";

  // Orders
  static const myOrders = "myOrders";
  static const orderDetails = "orderDetails";
  static const active = "active";
  static const completed = "completed";
  static const canceled = "canceled";
  static const cancelOrder = "cancelOrder";
  static const trackDriver = "trackDriver";
  static const orderDelivered = "orderDelivered";
  static const orderCancelled = "orderCancelled";
  static const noOrdersMessage = "noOrdersMessage";
  static const totalOrder = "totalOrder";
  static const item = "item";
  static const items = "items";

  // Favorites
  static const myFavorites = "myFavorites";
  static const noFavoritesYet = "noFavoritesYet";

  // Product
  static const product = "product";

  // Profile
  static const profile = "profile";
  static const home = "home";

  // Settings
  static const settings = "settings";
  static const language = "language";

  // General
  static const hello = "hello";
  static const addTask = "addTask";
  static const title = "title";
  static const description = "description";
  static const group = "group";
  static const endDate = "endDate";
  static const userName = "userName";
}