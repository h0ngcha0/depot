require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "test the attribute of the product can not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "test the price of the product must be greater than 0.0.1" do
    product = Product.new(:title       => "My Book",
                          :description => "My Description",
                          :image_url   => "bla.jpg")

    [-1, 0, 0.001].each do |n|
      product.price = n
      assert product.invalid?
      assert_equal "must be greater than or equal to 0.01",
      product.errors[:price].join(" ")
    end
  end

  test "test the url of the product" do
    product = Product.new(:title       => "My Book",
                          :description => "My Description",
                          :price       => 100)

    ok = %w{bla.jpg foo.png eee.gif}
    bad = %w{bla foo.jg eee.g}

    ok.each do |url|
      product.image_url = url
      assert product.valid?
    end

    bad.each do |url|
      product.image_url = url
      assert product.invalid?
    end
  end
end
