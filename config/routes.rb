Rails.application.routes.draw do
  resources :works, only: %i[index show] do
    collection do
      get :residential
      get :"residential-rental"
    end
  end
  get 'building', to: "services#building"
  get 'interior', to: "services#interior"
  get 'planning', to: "services#planning"
  get 'landscape', to: "services#landscape"
  get 'vetting', to: "services#vetting"
  get 'consluting', to: "services#consluting"
  get 'vr-tech', to: "services#vrtech"

  resources :sites, only: [] do
    collection do
      get :statement
      get :privacy
      get :disclaimer
    end
  end

  root 'home#show'
end
