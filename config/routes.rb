Rails.application.routes.draw do
  root :to => 'home#index'

  mount ShopifyApp::Engine, at: '/'
  namespace :shopify_app do
    resources :webhooks, only: [], defaults: { format: 'json' } do
      collection do
        get :receive
      end
    end
  end
  resources :dashboard, only: [:index]
  resources :products, only: [:index, :show]
  resources :descriptions, only: [:index, :show, :update]
  resource :marketings, only: :show do
    member do
      get :facebook_ad_headline
      get :facebook_ad_primary_text
      get :instagram_post_caption
      get :google_headlines
      get :google_descriptions
      get :tiktok
      get :pinterest
    end
  end
  resources :hot_selling, only: [:index]
  resources :least_selling, only: [:index]

  resources :custom, only: [] do
    collection do
      get :hot_selling
      get :least_selling
      get :description
      get :ai_marketing
      get :description_form
      get :facebook_form
      get :pinterest_form
      get :instagram_form
      get :settings
      get :qr_generator
      get :qr_editor
      get :qr_analytics
      get :ai_canvas
      get :aiwizard_landing
    end
  end
  resources :variants, only: [:show]

  resources :qr_codes do
    collection do
      get :generate_qr_code
    end
  end
  resources :file_uploader, only: [:create] do
    collection do
      get :download_image
    end
  end
  resources :data_synchronization, only: [] do
    collection do
      get :all
      get :product
    end
  end
  resources :landing_page, only: [:index]
  resources :qr_code_reader, only: [] do
    member do
      get :scan
    end
  end
  resources :qr_analytics, only: [:index] do
    collection do
      get :download_csv
    end
  end
end