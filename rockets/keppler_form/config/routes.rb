KepplerForm::Engine.routes.draw do
  namespace :app do
    scope :form, as: :form do
      resources :polls do
      end
    end
  end

  namespace :admin do
    scope :form, as: :form do
      resources :polls do
        get '(page/:page)', action: :index, on: :collection, as: ''
        get '/clone', action: :clone
        post '/upload', action: :upload
        get '/download', action: :download
        get '/reload', action: :reload, on: :collection
        delete '(page/:page)/destroy_multiple', action: :destroy_multiple, on: :collection

        get '/question/create/:question_type', to: 'questions#create', as: :question_create
        delete '/question/delete/:id', to: 'questions#delete', as: :question_delete
        get '/question/edit/:id/', to: 'questions#edit', as: :question_edit
        delete '/question/:id/delete_option/:option_id', to: 'questions#delete_option', as: :question_delete_option
        post '/question/:id/add_option/', to: 'questions#add_option', as: :question_add_option

        get '/:poll_id/statistics(.:format)', to: 'polls#poll_statistics', as: :statistics

        resources :questions do
          get '(page/:page)', action: :index, on: :collection, as: ''
          get '/clone', action: 'clone'
          delete '(page/:page)/destroy_multiple', action: :destroy_multiple, on: :collection
        end

        resources :results do
          get '(page/:page)', action: :index, on: :collection, as: ''
          get '/clone', action: 'clone'
          delete '(page/:page)/destroy_multiple', action: :destroy_multiple, on: :collection
          get '/reload', action: :reload, on: :collection
        end
      end
    end
  end
end
