class CategoryController < ApplicationController
  def index
    if !params[:q]
      @categories = Category.all
    else
      @categories = categories_sorter
    end
  end

  def show
    @category = Category.find(params[:id])
    @users = @category.users
  end

  def categories_sorter
    case params[:q]
      when 'name'
        Category.all.sort_by(&:name)
      when 'num_goals'
        Category.all.sort_by(&:num_goals).reverse
      else
        Category.all
    end
  end

end
