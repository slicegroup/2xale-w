# frozen_string_literal: true

require_dependency "keppler_products/application_controller"
module KepplerProducts
  module Admin
    # CategoriesController
    class CategoriesController < ::Admin::AdminController
      layout 'keppler_products/admin/layouts/application'
      before_action :set_category, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /products
      def index
        respond_to_formats(@categories)
        redirect_to_index(@objects)
      end

      # GET /products/1
      def show; end

      # GET /products/new
      def new
        @category = Category.new
      end

      # GET /products/1/edit
      def edit; end

      # POST /products
      def create
        @category = Category.new(category_params)

        if @category.save
          redirect(@category, params)
        else
          render :new
        end
      end

      # PATCH/PUT /products/1
      def update
        if @category.update(category_params)
          redirect(@category, params)
        else
          render :edit
        end
      end

      def clone
        @category = Category.clone_record params[:category_id]
        @category.save
        redirect_to_index(@objects)
      end

      # DELETE /products/1
      def destroy
        @category.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Category.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Category.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Category.sorter(params[:row])
      end

      private

      def index_variables
        @q = Category.ransack(params[:q])
        @categories = @q.result(distinct: true)
        @objects = @categories.page(@current_page).order(position: :desc)
        @total = @categories.size
        @attributes = Category.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def category_params
        params.require(:category).permit(
          :name, :featured
        )
      end
    end
  end
end