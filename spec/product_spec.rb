require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here

    it 'saves with all four fields set' do
      @category = Category.new(name: 'Hat')
      @product = Product.new(
        name: 'Best Name',
        description: 'Best Description',
        quantity: 5,
        price_cents: 20,
        category: @category
      )
      expect(@product).to be_valid
    end

    it 'validates :name, presence: true' do
      @category = Category.new(name: 'Hat')
      @product = Product.new(
        name: nil,
        description: 'Best Description',
        quantity: 5,
        price_cents: 20,
        category: @category
      )
      @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates :price, presence: true' do
      @category = Category.new(name: 'Hat')
      @product = Product.new(
        name: 'Best Name',
        description: 'Best Description',
        quantity: 5,
        price_cents: nil,
        category: @category
      )
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates :quantity, presence: true' do
      @category = Category.new(name: 'Hat')
      @product = Product.new(
        name: 'Best Name',
        description: 'Best Description',
        quantity: nil,
        price_cents: 20,
        category: @category
      )
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      @category = Category.new(name: 'Hat')
      @product = Product.new(
        name: 'Best Name',
        description: 'Best Description',
        quantity: 5,
        price_cents: 20,
        category: nil
      )
      @product.valid?
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
    
  end
end