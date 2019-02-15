Rails.application.routes.draw do
  mount KepplerProducts::Engine => "/keppler_products"
end
