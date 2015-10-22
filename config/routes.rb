Rails.application.routes.draw do
  
  resources :careers do
    resources :functions
    resources :jobskills
  end

  devise_for :recruiters, controllers: {recruiterregistrations: "recruiterregistrations"}
  devise_for :trainers, controllers: {registrations: "registrations",omniauth_callbacks: "trainers/omniauth_callbacks"}

  resources :qualifications
  resources :expertises
  resources :programs
  resources :savedprograms 
  
  resources :trainers do
	 resources :qualifications
   resources :expertises
   resources :savedprograms
  end

  resources :recruiters do
   resources :programs
   #resources :expertises
  end

  
  get '/auth/:provider/callback', to: 'sessions#create', via: :get
  get 'recruiters/myaccount' => "recruiters#show", as: :recruiter_root
  get 'recruiters/:id/update' => "recruiters/registrations#edit"
  get ":page" => "pages#show"
  get 'trainers/profile' => "trainers#show", as: :trainer_root
  get 'trainers-list' => "trainers#index"
  get 'programs.:id/update' => "programs#edit"
  get 'expertise-list' => "expertises#index"
  get 'trainers/:id/update' => "devise/registrations#edit"
  #get 'trainers' => "devise/registrations#edit"
  post 'savedprograms/:id'=>'savedprograms#savedlist'
  #get 'recruiters/:id/edit' => "programs#edit"
  get "home/index"
  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
