# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@gmail.com',
  password: 'teamsmile'
)

20.times do |n|
  Customer.create!(
    first_name: "太郎#{n}",
    last_name: "てすと",
    first_name_kana: "タロウ",
    last_name_kana: "テスト",
    postal_code: "000#{n}",
    address: "テストデータ住所#{n}",
    tel: "0800000#{n}",
    email: "user#{n}@test.com",
    password: "testtest"
  )
end

Customer.all.each do |customer|
  rand(0..3).times do |n|
    Address.create!(
      customer_id: customer.id,
      address_name: "#{customer.last_name}#{customer.first_name}の住所#{n}",
      address: "#{customer.address}-#{n}",
      postal_code: "0000#{customer.id}#{n}"
    )
  end
end

5.times do |n|
  Genre.create!(
    name: "テストジャンル#{n}"
  )
end

Genre.all.each do |genre|
  rand(0..10).times do |n|
    Product.create!(
      genre_id: genre.id,
      name: "テスト商品#{genre.id}-#{n}",
      introduction: "テスト商品#{genre.id}-#{n}の説明",
      price: 100*rand(1..20),
      image: File.open("#{Rails.root}/app/assets/images/test_image.png")
    )
  end
end

Customer.all.each do |customer|
  rand(0..3).times do
    products = Product.all.sample(rand(1..10))
    total_price = 0
    order_details = []
    products.each do |product|
      order_detail = OrderDetail.new(
        product_id: product.id,
        quantity: rand(1..5),
        tax_included_price: product.tax_price
      )
      total_price += order_detail.quantity * order_detail.tax_included_price
      order_details.push(order_detail)
    end
    
    total_price += 800

    order = Order.create!(
      customer_id: customer.id,
      shipping_fee: 800,
      total_price: total_price,
      payment_method: rand(0..1),
      address_name: customer.last_name+customer.first_name,
      address: customer.address,
      postal_code: customer.postal_code
    )

    order_details.each do |order_detail|
      order_detail.order_id = order.id
      order_detail.save
    end
  end
end