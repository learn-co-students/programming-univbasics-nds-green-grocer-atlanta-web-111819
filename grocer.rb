require 'pry'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  while index < collection.length
    if collection[index][:item] == name
       return collection[index]
         end
         index += 1

end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  updated_cart = []
  cart_item = 0
  while cart_item < cart.length
    #puts new item into a variable "new_addtion"
    #New item can be called by the previous method
    new_additon = find_item_by_name_in_collection(cart[cart_item][:item], updated_cart)
    if new_additon != nil
      #if new item to be added is currently in the cart, add 1 to the item count
      new_additon[:count] += 1
    else
      #Since item is not in currently in the cart, we will create the item from scratch
      new_additon = {
        :item => cart[cart_item][:item],
        :price => cart[cart_item][:price],
        :clearance => cart[cart_item][:clearance],
        :count => 1,
      }
      #We then add the new additon to the updated cart
      updated_cart << new_additon
  end
   cart_item += 1
end
#Return the updated cart
updated_cart
end

def apply_coupons(cart, coupons)
  #LOGIC
  #1 Check the coupons against the items in the cart to see if any can have coupons applied
  #2

  #loop through the coupons to see if the coupon matches anything in our cart
   count = 0
   while count  < coupons.length
     #We can use our find_item_by_name_in_collection method to chek items in our cart.
     #First, set a variable forthe couponed item
     item = find_item_by_name_in_collection(coupons[count][:item], cart)
     #Set a variable for each coupon in the collection of coupons
     item_coupon_name = "#{coupons[count][:item]} W/COUPON"
     #Create a variable for an item within the cart that has a copuon
     item_with_coupon = find_item_by_name_in_collection(item_coupon_name, cart)
     #Check to see if item is in cart
     #And check if item[:count] is greater than or equal items required to redeem the coupon
     if item && item[:count] >= coupons[count][:num]
       #If the item with coupon is in the cart
        if item_with_coupon
          #Increase item with coupon by the number required to redeem
          item_with_coupon[:count] += coupons[count][:num]
          #remove coupon from the collection of coupons
          item[:count] -= coupons[count][:num]
          #If the cart item does not exist
        else
          item_with_coupon = {
            :item => item_coupon_name,
            #Cost of the number of items on the coupon divided by the number of items it applies to
            #This will give the discounted price of each item
            :price => coupons[count][:cost] / coupons[count][:num],
            :count => coupons[count][:num],
            :clearance => item[:clearance]
          }
          #add item with coupon to cart
          cart << item_with_coupon
          item[:count] -= coupons[count][:num]
        end
     end
     count +=1
    end
    cart
   end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #Loop through the cart
  count =0
  while count < cart.length
    #Check item to see if it on clearance or has the clearance key
    if cart[count][:clearance]
      #Update item in cart price  by applying 20% discount
      cart[count][:price] = (cart[count][:price] * 0.8).round(2)
    end
    count += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance

  #First, create variable to store the consolidated cart
  cart_consolidated = consolidate_cart(cart)
  cart_after_coupons = apply_coupons(cart_consolidated, coupons)
  cart_at_checkout= apply_clearance(cart_after_coupons)

  total_at_checkout = 0
  index = 0
  while index < cart_at_checkout.length
    total_at_checkout += cart_at_checkout[index][:price] * cart_at_checkout[index][:count]
    index += 1
  end
  #Apply 10% discount if total over $100
  if total_at_checkout > 100
   total_at_checkout = (total_at_checkout * 0.9).round(2)
  end
    total_at_checkout
end
