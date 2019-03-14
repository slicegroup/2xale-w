# frozen_string_literal: true

require_dependency "keppler_products/application_controller"
module KepplerProducts
  module Admin
    # CotizationsController
    class CotizationsController < ::Admin::AdminController
      layout 'keppler_products/admin/layouts/application'
      before_action :set_cotization, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /products
      def index
        respond_to do |format|
          format.html
          format.xls
          format.json { render json: json_objects(@cotizations) }
        end
        redirect_to_index(@objects)
      end

      # GET /products/1
      def show; end

      # GET /products/new
      def new
        @cotization = Cotization.new
      end

      # GET /products/1/edit
      def edit; end

      # POST /products
      def create
        @cotization = Cotization.new(cotization_params)

        if @cotization.save
          redirect(@cotization, params)
        else
          render :new
        end
      end

      # PATCH/PUT /products/1
      def update
        if @cotization.update(cotization_params)
          redirect(@cotization, params)
        else
          render :edit
        end
      end

      def clone
        @cotization = Cotization.clone_record params[:cotization_id]
        @cotization.save
        redirect_to_index(@objects)
      end

      # DELETE /products/1
      def destroy
        @cotization.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Cotization.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Cotization.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Cotization.sorter(params[:row])
      end

      private

      def index_variables
        @q = Cotization.ransack(params[:q])
        @cotizations = @q.result(distinct: true)
        @objects = @cotizations.page(@current_page).order(position: :desc)
        @total = @cotizations.size
        @attributes = Cotization.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_cotization
        @cotization = Cotization.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def cotization_params
        params.require(:cotization).permit(
          :product_id, :content
        )
      end
    end
  end
end