Rails.application.routes.draw do
         post '/checkout/create',to: 'checkout#create', as: 'checkout_create'
         get "stripe/connect", to: "stripe#connect", as: :stripe_connect
         post '/disconnect'                           ,to: "stripe#disconnect",as: :disconnect
         get '/payment_gateway'                       ,to: "stripe#payment_gateway"

         get '/save_card'                       ,to: "stripe#save_card"
         post '/delete_card'                       ,to: "stripe#deletecard"      
         post 'stripe/savecard', to: 'stripe#carddetailsave'

           get '/dashboard'    , to: 'dashboard#index'

           
           get "show"                        ,to: "dashboard#show_page"                         
          



  namespace :admin do
    get 'reports/show'
  end
  get 'session/new'
  get 'session/login'
  get 'session/logout'
  root 'home#index'
  resources :user_details
  resources :users
  resources :funnels
  

  
  get '/login'                                ,to: "session#new"
  get '/logout'                               ,to: "session#logout"
  get '/signup'                               ,to: "users#new"
 post '/funnel/block_unblock'                 ,to: "users#block"

  post '/signin'                              ,to: "session#login"
  get 'confirm'                               ,to: "users#confirm_msg"
  get "/confirm_mail/:token"                  ,to: "users#confirm_email"                          ,as: :confirm_mail
  get "reset/:token"                          ,to: "password#reset"                               ,as: :reset
  patch "reset_pass/:id"                      ,to: "users#reset_password"                         ,as: :reset_pass
  get "forget"                                ,to: "password#forget"
  post "verify"                               ,to: "password#verify"
  get "funnel_url/:id"                        ,to: "funnels#show_funnel"                          ,as: :funnel_url
  
  post "page_form/:id"                        ,to: "page_columns#create"                          ,as: :page_form
  get "not_found"                             ,to: "funnels#not_found"                            ,as: :not_found
  get "preview/:id"                           ,to: "funnels#preview"                              ,as: :preview
  mount ActionCable.server => '/cable'
#======================================================= admin  routes ===============================================================
  namespace :admin do
    resources :users
    root "home#index"
    get '/login'                              ,to: "session#new"
    get '/logout'                             ,to: "session#logout"
    post '/signin'                            ,to: "session#login"
    get '/new_pass'                           ,to: "users#new_pass"
    get '/profile/:id'                        ,to: "users#profile"                                 ,as: :profile
    
    post '/change_pass'                       ,to: "users#change_password"
    resources :user_details
    resources :funnels
    resources :pages
    get '/report/:id'                         ,to: "reports#show"                                 ,as: :report
    get "funnels/:id"                           ,to: "funnels#show_funnel"                          
    get '/reports'                            ,to: "reports#index"                                ,as: :reports
    resources :notifications

    get '/statics'                            ,to: "statics#index"                                ,as: :statics #statics
    get '/faq'                                ,to: "statics#showfaq"                                
    get '/contactus'                          ,to: "statics#showcontact"                                
    get '/tc'                                 ,to: "statics#showtc"                                
    get '/privacypolicy'                      ,to: "statics#showpp"                                
    post '/create',                            to: 'statics#create'
 

  end

#======================================================== api routes =====================================================================
  namespace :api do
    namespace :v1 do
      root    'home#index'
      post    'user_token'                    ,to: 'user_token#create'
      get     'auth'                          ,to: 'home#auth'  
      post    'user_token'                    ,to: 'user_token#create'    
      post    'login'                         ,to: 'auth#login'                                                               #login
      get     'logout'                        ,to: 'auth#logout'                                                              #logout
      get     '/users'                        ,to: 'users#index'          
      get     '/users/current'                ,to: 'users#current'        
      post    '/signup'                       ,to: 'users#create'                                                             #sign up
      patch   '/user/update'                  ,to: 'users#update'                                                             #update user
      delete  '/user/:id'                     ,to: 'users#destroy'                                                            #delete user
      get     '/user/:id'                     ,to: "users#show"                                                               #user profile
      get     '/edit/user/:id'                ,to: "users#edit"                                                               #edit user profile
      get     '/edit/user_detail/:id'         ,to: "user_details#edit"                                                        #edit user details
      patch   '/user_details/:id'             ,to: "user_details#update"                                                      #update user details
      post    '/forget'                       ,to: "users#verify"                                                          #forget password
      post    '/change_password'              ,to: "users#change_password"                        ,as: :change_password       #chnage password
      get     '/confirm_mail'                 ,to: "users#confirm_email"
      post    '/funnel/new'                   ,to: "funnels#create"                                                           #create funnel
      post    '/add_code'                   ,to: "pages#add_code"                                                           #add  code 

      post    '/funnel/newfunnel'             ,to: "funnels#create_funnel"                                                    #Pradeep Prajapati >> create funnel empty
      
      get     '/pagecodedata/:id'                 ,to: "pages#get_page_codedata"                                                #get page code data

      get     '/pagedata/:id'                 ,to: "pages#get_data_page_wise"                                                 #Pradeep Prajapati >> Show page data against page id
     # get     '/columns_show/:id'             ,to: "page_columns#show_all"                        ,as: :columns_show          #show form columns OR DATA AGAINST PAGE ID
      get     '/elements_show/:id'            ,to: "funnels#show_records"                         ,as: :elements_show         #show elements
      get     '/funnels_show'                 ,to: "funnels#show_funnel"                          ,as: :funnels_show          #show funnels
      get     '/delete_funnel/:id'            ,to: "funnels#destroy"                              ,as: :delete_funnel         #delete funnel
      get     '/delete_page/:id'              ,to: "pages#destroy"                                ,as: :delete_page           #delete page
      get     '/funnel_detail/:id'            ,to: "funnels#show"                                 ,as: :funnel_detail         #show detail
      post    '/preview'                      ,to: "funnels#preview"                              ,as: :preview               #preview link
      post    '/upload'                       ,to: "uploads#create"                               ,as: :upload                #upload assets
      get     '/files'                        ,to: "uploads#show"                                 ,as: :files                 #get assetss
      post    '/funnel/rename/:id'            ,to: "funnels#rename"                                                           #Pradeep Prajapati >> rename funnel
      post    '/renamepage/:id'               ,to: "pages#rename"                                                             #Pradeep Prajapati >> rename page
      get     '/upload/delete_asset/:id'      ,to: "uploads#destroy"                              ,as: :delete_asset          #delete asset 

      get     '/static_page_show'                 ,to: "pages#show_static_page"                          ,as: :show_static_page          #show statics page

    end
  end
  
  scope '/checkout' do 
    #  post 'create',to: 'checkout#create', as: 'checkout_create'
     get 'cancel',to: 'checkout#cancel', as:  'checkout_cancel'
     get 'success',to: 'checkout#success', as: 'checkout_success'
   end
   
end