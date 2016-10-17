class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :logged_in_as_admin
  before_action :load_category, except: [:new, :create, :index]

  def index
    if params[:search]
      @categories = Category.search params[:search]
    else
      @categories = Category.update_desc
    end
    @categories = @categories.paginate(page: params[:page])
      .per_page Settings.per_page.category
  end

  def new
    @category = Category.new
  end

  def show
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:success] = t "category_updated_success"
      redirect_to admin_category_path @category
    else
      render :edit
    end
  end

  def destroy
    if @category.any_words_inside?
      flash[:danger] = t "category_deleted_fail_cos_word"
    else
      if @category.destroy
        flash[:sucess] = t "category_deleted_success"
      else
        flash[:danger] = t "category_deleted_fail"
      end
    end
    redirect_to admin_categories_path
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:sucess] = t "category_created_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description, :category_img
  end
end
