# frozen_string_literal: true

require_dependency "keppler_banners/application_controller"
module KepplerBanners
  module Admin
    # BannersController
    class BannersController < ::Admin::AdminController
      layout 'keppler_banners/admin/layouts/application'
      before_action :set_banner, only: %i[show edit update destroy]
      before_action :index_variables
      include ObjectQuery

      # GET /banners
      def index
        respond_to_formats(@banners)
        redirect_to_index(@objects)
      end

      # GET /banners/1
      def show; end

      # GET /banners/new
      def new
        @banner = Banner.new
      end

      # GET /banners/1/edit
      def edit; end

      # POST /banners
      def create
        @banner = Banner.new(banner_params)

        if @banner.save
          redirect(@banner, params)
        else
          render :new
        end
      end

      # PATCH/PUT /banners/1
      def update
        if @banner.update(banner_params)
          redirect(@banner, params)
        else
          render :edit
        end
      end

      def clone
        @banner = Banner.clone_record params[:banner_id]
        @banner.save
        redirect_to_index(@objects)
      end

      def toggle
        Banner.find(params[:banner_id]).update(active: params[:banner][:active])
        redirect_to_index(@objects)
      end

      # DELETE /banners/1
      def destroy
        @banner.destroy
        redirect_to_index(@objects)
      end

      def destroy_multiple
        Banner.destroy redefine_ids(params[:multiple_ids])
        redirect_to_index(@objects)
      end

      def upload
        Banner.upload(params[:file])
        redirect_to_index(@objects)
      end

      def reload; end

      def sort
        Banner.sorter(params[:row])
      end

      private

      def index_variables
        @q = Banner.ransack(params[:q])
        @banners = @q.result(distinct: true)
        @objects = @banners.page(@current_page).order(position: :desc)
        @total = @banners.size
        @attributes = Banner.index_attributes
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_banner
        @banner = Banner.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def banner_params
        params.require(:banner).permit(
          :title, :image, :search_text, :url
        )
      end
    end
  end
end