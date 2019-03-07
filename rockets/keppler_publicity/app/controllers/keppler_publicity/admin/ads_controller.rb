# frozen_string_literal: true

require_dependency "keppler_publicity/application_controller"
module KepplerPublicity
  module Admin
    # AdsController
    class AdsController < ::Admin::AdminController
      layout 'keppler_publicity/admin/layouts/application'
      before_action :set_ad, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /publicities
      def index
        respond_to_formats(@ads)
        redirect_to_index(@objects)
      end

      # GET /publicities/1
      def show; end

      # GET /publicities/new
      def new
        @ad = Ad.new
      end

      # GET /publicities/1/edit
      def edit; end

      # POST /publicities
      def create
        byebug
        @ad_exist = KepplerPublicity::Ad.where(
          type_ad: params[:ad][:type_ad], 
          location: params[:ad][:location]
          )
        if @ad_exist.any?
          @ad_exist.update(image: params[:ad][:image])
        else
          @ad = Ad.create(ad_params)
        end

        # if @ad.save
        #   redirect(@ad, params)
        # else
        #   render :new
        # end
      end

      # PATCH/PUT /publicities/1
      def update
        if @ad.update(ad_params)
          redirect(@ad, params)
        else
          render :edit
        end
      end

      def clone
        @ad = Ad.clone_record params[:ad_id]
        @ad.save
        redirect_to_index(@objects)
      end

      # DELETE /publicities/1
      def destroy
        @ad.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Ad.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Ad.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Ad.sorter(params[:row])
      end

      private

      def index_variables
        @q = Ad.ransack(params[:q])
        @ads = @q.result(distinct: true)
        @objects = @ads.page(@current_page).order(position: :desc)
        @total = @ads.size
        @attributes = Ad.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_ad
        @ad = Ad.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def ad_params
        params.require(:ad).permit(
          :image, :type_ad, :location, :active
        )
      end
    end
  end
end