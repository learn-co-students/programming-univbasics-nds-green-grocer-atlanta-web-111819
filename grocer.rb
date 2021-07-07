def find_item_by_name_in_collection(name, collection)
  row_index = 0 
  item = {}
  
  while row_index < collection.length Don
  if name == collection[row_index][:item]
    item = collection[row_index]
  else
    item << nil
end
row_index += 1 
end
item
  # Implement me first!
  #
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  
  row_index = 0 
  result = []
  
  while row_index < cart.length do
    item = cart[row_index][:item]
    new_item = find_item_by_name_in_collection(item, result)
    if new_item 
      new_item[:count] += 1 
    else
      cart[row_index][:count] = 1 
      result << cart[row_index]
  end
  row_index += 1 
end
result
  
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  row_index = 0 
  
  while row_index < coupons.length do
    new_coupon = coupons[row_index]
    item_coupon = find_item_by_name_in_collection(new_coupon[:item], cart)
    item_basket != item_coupon 
    apply_coupon = item_basket && item_coupon[:count] >= new_coupon[:num]
    
    if item_basket && apply_coupon
      app_cart(item_coupon, new_coupon, cart)
  end
  row_index += 1 
  end
  cart
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
