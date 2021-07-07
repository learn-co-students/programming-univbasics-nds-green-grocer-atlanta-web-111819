require 'pp'

def cart_total(cart)
  total = 0
  cart.each do |item|
    item_total = item[:price] * item[:count]
    total += item_total
  end
  total
end

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.detect do |item|
    name == item[:item]
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  # puts "cart before consolidation:"
  # pp cart
  consolidated_cart = []
  intermediate_cart = {}

  cart.each do |item|
    if intermediate_cart[item[:item]]
      intermediate_cart[item[:item]][:count] += 1
    else
      intermediate_item = item
      intermediate_item[:count] = 1
      intermediate_cart[item[:item]] = intermediate_item
    end
  end

  intermediate_cart.each do |item_name, item|
    consolidated_cart << item
  end
  # puts "Cart after consolidation"
  # pp consolidated_cart
  consolidated_cart
end

def cart_to_hash_by_item(cart)
  cart_hash = {}
  cart.each do |item|
    cart_hash[item[:item]] = item
  end
  cart_hash
end

def hash_cart_to_array(hash_cart)
  array = []
  hash_cart.each do |name, item|
    array << item
  end
  array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #puts "Cart before coupons:"
  #pp cart
  intermediate_cart = cart_to_hash_by_item(cart)

  coupons.each do |coupon|
    item = coupon[:item]
    if intermediate_cart[item] and intermediate_cart[item][:count] >= coupon[:num]
      price = coupon[:cost] / coupon[:num]
      item_name = "#{item} W/COUPON"
      count = coupon[:num]
      clearance = intermediate_cart[coupon[:item]][:clearance]

      new_item = {item: item_name, price: price, clearance: clearance, count: count}

      intermediate_cart[item][:count] -= count
      intermediate_cart[item_name] = new_item
    end
  end
  cart = hash_cart_to_array(intermediate_cart)
  #puts "Cart after coupons:"
  #pp cart
  #puts "The cart total is #{cart_total(cart)}"
  #cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #puts "cart before clearance:"
  #pp cart
  cart.each do |item|
    if item[:clearance]
      new_price = item[:price] - item[:price] * 0.2
      item[:price] = new_price.round(2)
    end
  end
  #puts "Cart after clearance"
  #pp cart
  cart
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
  # pp cart
  consolidated_cart = consolidate_cart(cart)
  #puts "Cart before coupons:"
  #pp consolidated_cart
  consolidated_cart = apply_coupons(consolidated_cart, coupons)
  #puts "Cart after coupons:"
  #pp consolidated_cart
  consolidated_cart = apply_clearance(consolidated_cart)

  # pp cart
  total = 0
  consolidated_cart.each do |item|
    item_total = item[:price] * item[:count]
    total += item_total
  end

  if total > 100.00
    total -= total * 0.1
  end

  total
end
