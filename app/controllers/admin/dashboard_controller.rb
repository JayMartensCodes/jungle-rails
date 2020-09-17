class Admin::DashboardController < ApplicationController
  def show
    @numberOfProducts = Product.count
    @numberOfCategories = Category.count
  end
end
