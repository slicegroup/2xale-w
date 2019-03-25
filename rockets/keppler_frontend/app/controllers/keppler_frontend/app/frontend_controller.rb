require_dependency "keppler_frontend/application_controller"

module KepplerFrontend
  class App::FrontendController < App::AppController
    # Begin callbacks area (don't delete)
    # End callbacks area (don't delete)
    include FrontsHelper
    before_action :products_status
    before_action :set_product, only: %i[index category search]
    layout 'layouts/keppler_frontend/app/layouts/application'

    # begin keppler
    def index
      @banners = KepplerBanners::Banner.all
      @products_six = KepplerProducts::Product.featureds
      @products_four = KepplerProducts::Product.featureds.last(4)
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
      @product = KepplerProducts::Product.find(params[:product_id])
      if verify_recaptcha(model: @message, timeout: 10, message: "Oh! It's error with reCAPTCHA!")
        @poll = KepplerForm::Poll.first
        body = "#{@poll.questions.map { |q| '<b>' + q.sentence + ': <b/>' + ((%w[short_text numeric long_text yes_or_not].include?(q.ask_type) ? params[q.ask_type.underscore + '-' + q.id.to_s]['answer'] : q.options.map { |o| (params[q.ask_type.underscore + '-' + q.id.to_s]['answer'][o.id.to_s] unless params[q.ask_type.underscore + '-' + q.id.to_s].blank?) }.join(', ')))}}"
        @cotization = KepplerProducts::Cotization.create( 
          product_id: @product.id,
          product_name: @product.name,
          product_price: @product.price,
          expiration: @product.expiration,
          content: body
        )
        ContactMailer.send_cotization(@cotization).deliver_now
        flash[:notice] = "Mensaje enviado"
      end
      # byebug
      redirect_to app_product_path(@product.id)
    end

    def category
      @category = KepplerProducts::Category.find(params[:id])
      @products_total = KepplerProducts::Product.actives.where(category_id: @category.id).page(params[:page]).per(12)
      @products = @products_total.first(12)
      @count = @products.count
    end

    def search
      @q = params[:q]
      @products_total = KepplerProducts::Product.actives.ransack(description_or_name_cont: @q).result.page(params[:page]).per(12)
      @products = @products_total.first(12)
      @count = @products.count
    end

    def about
      @message = KepplerContactUs::Message.new
    end

    def message_contact
      if verify_recaptcha(model: @message, timeout: 10, message: "Oh! It's error with reCAPTCHA!")
        @message =  KepplerContactUs::Message.create(
          name: params[:name],
          from_email: params[:email],
          subject: params[:subject],
          phone: params[:phone],
          content: params[:message],
          )
        ContactMailer.send_message(@message).deliver_now
        ContactMailer.thanks(@message).deliver_now
        flash[:notice] = "Mensaje enviado"
      end
      redirect_to app_about_path
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
