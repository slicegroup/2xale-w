require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    # Begin callbacks area (don't delete)
    # End callbacks area (don't delete)
    include FrontsHelper
    before_action :products_status
    before_action :set_product, only: %i[index category]
    layout 'layouts/keppler_frontend/app/layouts/application'

    # begin keppler
    def index
      @banners = KepplerBanners::Banner.all
      @products = KepplerProducts::Product.latest
      @categories_featureds = KepplerProducts::Category.featureds
    end
    # end keppler

    def product
      @product = KepplerProducts::Product.find(params[:product_id])
      category = @product.category_id
      @products = KepplerProducts::Product.find_by_category(
        category, 
        @product.id
      )
      @poll = KepplerForm::Poll.first
      @result = KepplerForm::Result.new
    end

    def new_cotization
      @poll = KepplerForm::Poll.first
      @product = KepplerProducts::Product.find(params[:product_id])
      body = "#{@poll.questions.map { |q| '<b>' + q.sentence + ': <b/>' + ((%w[short_text numeric long_text yes_or_not].include?(q.ask_type) ? params[q.ask_type.underscore + '-' + q.id.to_s]['answer'] : q.options.map { |o| (params[q.ask_type.underscore + '-' + q.id.to_s]['answer'][o.id.to_s] unless params[q.ask_type.underscore + '-' + q.id.to_s].blank?) }.join(', ')))}}"
      @cotization = KepplerProducts::Cotization.create( 
        product_id: @product.id,
        product_name: @product.name,
        product_price: @product.price,
        expiration: @product.expiration,
        content: body
      )
      flash[:notice] = "Mensaje enviado"
      redirect_to app_product_path(@product.id)
    end

    def category
      if params[:q]
        @q = params[:q]
        @products = KepplerProducts::Product.actives.ransack(description_or_name_cont: @q).result
      else
        @category = KepplerProducts::Category.find(params[:id])
        @products = KepplerProducts::Product.actives.where(category_id: @category.id)
      end
    end

    private

    def products_status
      KepplerProducts::Product.products_actives
    end
    # begin callback user_authenticate
    def user_authenticate
      redirect_to '/' unless user_signed_in?
    end
    # end callback user_authenticate
    def set_product
      @product = KepplerProducts::Product.new
    end
  end
end
