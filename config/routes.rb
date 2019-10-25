Rails.application.routes.draw do
  get 'group/group_home'
  get 'group/group_delete'
  get 'admin_page/new'
  get 'admin_page/create'
  get 'admin_page/sent_history'
 
 

  resources :notices
 devise_for :users, :controllers => { registrations: 'registrations' }
  as :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'pages#home'
  get '/login' => 'pages#login'

  match 'notices/send_email' ,to: 'notices#send_email',via: :post 
  match 'notices/send_id' ,to: 'notices#send_id',via: :post 
   match 'notices/reg_id' ,to: 'notices#reg_id',via: :post 
    match 'admin_page/new' ,to: 'admin_page#new',via: :post 
   match 'admin_page/create' ,to: 'admin_page#create',via: :post
   match 'admin_page/save' ,to: 'admin_page#save',via: :post 
    match 'group/group_home' ,to: 'group#group_home',via: :post 
    match 'group/group_delete' ,to: 'group#group_delete',via: :post
     match 'group/delete_group_btn' ,to: 'group#delete_group_btn',via: :post  
     match 'group/create_group_function' ,to: 'group#create_group_function',via: :post  

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
