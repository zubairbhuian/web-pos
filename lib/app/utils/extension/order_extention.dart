import 'package:yogo_pos/app/modules/onlineOrder/models/order_model.dart';

extension OrderModelExtensions on OrderModel {
  // This extension method converts the order to a bar order
  OrderModel toBar() {
    final allowedItemTypes = {
      "liquor",
      "non alcoholic drinks",
      "drinks",
      "carbonated",
    };

    return copyWith(
      carts: carts.where((cart) {
        return allowedItemTypes.contains(cart.itemType.toLowerCase());
      }).toList(),
    );
  }

  // This extension method converts the order to a kitchen order
  OrderModel toKitchen() {
    final allowedItemTypes = {
      "dessert",
      "veg",
      "non veg",
      "food",
      "single item",
    };
    return copyWith(
      carts: carts.where((cart) {
        return allowedItemTypes.contains(cart.itemType.toLowerCase());
      }).toList(),
    );
  }

  // This extension method filters the carts that are not updated
  OrderModel toNonUpdate() {
    return copyWith(
      carts: carts.where((cart) => !cart.isUpdated).toList(),
    );
  }

  // This extension method filters the carts by indices
  // OrderModel filterCartsByIndices(List<int> indices) {
  //   final filteredCarts = indices.map((index) => carts[index]).toList();
  //   return copyWith(
  //     carts: filteredCarts,
  //   );
  // }
  OrderModel filterCartsByIndices(List<String> indices) {
    final filteredCarts =
        indices.map((index) => carts[int.parse(index)]).toList();
    return copyWith(
      carts: filteredCarts,
    );
  }

  // This extension method removes selected items from the order
  OrderModel removeSelectedItems(List<String> selectedItemList) {
    if (selectedItemList.isNotEmpty) {
      // Convert list of string indices to list of int indices
      var indicesToRemove =
          selectedItemList.map((index) => int.parse(index)).toList();

      // Sort indices in descending order to prevent index shifting issues
      indicesToRemove.sort((a, b) => b.compareTo(a));

      // Remove items at specified indices
      List<CartModel> updatedCarts = List.from(carts);
      for (int index in indicesToRemove) {
        if (index < updatedCarts.length) {
          updatedCarts.removeAt(index);
        }
      }

      return copyWith(carts: updatedCarts);
    }
    return this;
  }
  // This extension method replicates selected items by indices
  // OrderModel replicateSelectedItems(List<String> selectedItemList) {
  //   if (selectedItemList.isNotEmpty) {
  //     // Convert list of string indices to list of int indices
  //     var indicesToReplicate = selectedItemList.map((index) => int.parse(index)).toList();

  //     // Replicate items at specified indices
  //     List<CartModel> updatedCarts = List.from(carts);
  //     for (int index in indicesToReplicate) {
  //       if (index < updatedCarts.length) {
  //         updatedCarts.add(updatedCarts[index]);
  //       }
  //     }

  //     return copyWith(carts: updatedCarts);
  //   }
  //   return this;
  // }
  OrderModel replicateSelectedItems(List<String> selectedItemList) {
    if (selectedItemList.isNotEmpty) {
      // Convert list of string indices to list of int indices
      var indicesToReplicate =
          selectedItemList.map((index) => int.parse(index)).toList();

      // Replicate items at specified indices
      List<CartModel> updatedCarts = List.from(carts);
      for (int index in indicesToReplicate) {
        if (index < updatedCarts.length) {
          var cartToReplicate = updatedCarts[index];
          var replicatedCart = cartToReplicate.copyWith(isUpdated: false);
          updatedCarts.add(replicatedCart);
        }
      }

      return copyWith(carts: updatedCarts);
    }
    return this;
  }
}
