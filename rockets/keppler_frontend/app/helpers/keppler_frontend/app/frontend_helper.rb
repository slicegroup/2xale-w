module KepplerFrontend
  module App::FrontendHelper
    # begin devise_login
    def devise_login(hash = {})
      render 'keppler_frontend/app/partials/devise_login', params: params
    end

    def publicity(type, ad)
    	render "keppler_frontend/app/frontend/partials/publicity_#{type}", ad: ad
    end
    # end devise_login
  end
end
