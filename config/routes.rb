Rails.application.routes.draw do
  get 'leave_forms/cl_form'
  get 'leave_forms/ch_form'
  get 'leave_forms/rh_form'
  get 'leave_forms/cancelLeave'
  get 'leave_forms/pl_form'
  get 'notices_dashboard/mySents'
  get 'notices_dashboard/myUploads'
  get 'notices_dashboard/myNotices'
  get 'notices/send_notice'
  get 'notices/sendcircular'
  get 'group/group_home'
  get 'group/delete_group_btn'
  get 'group/groupDetails'
  get 'group/group_details_show'
  get 'group/group_delete'
  get 'admin_page/new'
  get 'admin_page/create'
  get 'admin_page/sent_history'
  get 'notices/all_notices'
  get 'leave_forms/previewbtn'
  get 'leave_forms/chpreviewbtn'
  get 'leave_forms/chpreviewbtn'
  get 'leave_forms/rhpreviewbtn'
  get 'leave_forms/leaveCancellationApply'

  get 'leave_forms/pl_leave'
  get 'leave_forms/showleaveform'
  get 'leave_forms/showleaveformcancel'
  get 'leave_forms/my_approved_transactions'
  get 'leave_forms/my_rejected_transactions'
  get 'leave_forms/leaves_stats'
  get 'leave_forms/download'
  get 'notices/all_leave_applicants'
  get 'admin_page/approved_leave_transactions'
  get 'admin_page/rejected_leaves_transactions'

  get 'notices_dashboard/restricted_holiday_list'
  get 'notices_dashboard/csv'

  get 'notices_dashboard/sam'
  get 'notices_dashboard/show_restricted_holiday'
  get 'admin_page/incharge_allot'
  get 'admin_page/make_incharge'
  get 'admin_page/grantCH'
  get 'admin_page/leaveCancelRequest'
  get 'admin_page/dynamiccancelLeave'
  get 'admin_page/AllLeaveStats'

  get 'admin_page/personOnLeaveCalendar'
  get 'notices_dashboard/testCalendar'




  resources :csv do
    collection { post :import }
  end

  resources :notices
 devise_for :users, :controllers => { registrations: 'registrations' }
  as :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'pages#home'
  get '/login' => 'pages#login'
  get '/contact' => 'pages#contact'


  match 'notices/send_email' ,to: 'notices#send_email',via: :post 
  match 'notices/send_id' ,to: 'notices#send_id',via: :post
  match 'notices/accept_user' ,to: 'notices#accept_user',via: :post
  match 'notices/decline_user' ,to: 'notices#decline_user',via: :post
  match 'notices/accept_leave' ,to: 'notices#accept_leave',via: :post
  match 'notices/decline_leave' ,to: 'notices#decline_leave',via: :post

  match 'notices_dashboard/update_holiday_list' ,to: 'notices_dashboard#update_holiday_list',via: :post
  match 'notices_dashboard/restricted_holiday_list' ,to: 'notices_dashboard#restricted_holiday_list',via: :post
  match 'notices_dashboard/csv' ,to: 'notices_dashboard#csv',via: :post
  match 'notices_dashboard/sam' ,to: 'notices_dashboard#sam',via: :post



  match 'notices/reg_id' ,to: 'notices#reg_id',via: :post
  match 'admin_page/new' ,to: 'admin_page#new',via: :post
  match 'admin_page/dynamiccancelLeave' ,to: 'admin_page#dynamiccancelLeave',via: :post

  match 'admin_page/make_incharge' ,to: 'admin_page#make_incharge',via: :post
  match 'admin_page/create' ,to: 'admin_page#create',via: :post
  match 'admin_page/addch' ,to: 'admin_page#addch',via: :post
  match 'admin_page/save' ,to: 'admin_page#save',via: :post
  match 'group/group_home' ,to: 'group#group_home',via: :post
  match 'group/_form' ,to: 'group#_form',via: :post
  match 'group/group_delete' ,to: 'group#group_delete',via: :post
  match 'group/delete_group_btn' ,to: 'group#delete_group_btn',via: :post
  match '/group/delete_group_btn' ,to: 'group#delete_group_btn',via: :post
  match 'group/create_group_function' ,to: 'group#create_group_function',via: :post
  match 'group/group_details_show' ,to: 'group#group_details_show',via: :post
  match 'group/create_from_csv' ,to: 'group#create_from_csv',via: :post
  match 'leave_forms/previewbtn' ,to: 'leave_forms#previewbtn',via: :post
  match 'leave_forms/rhpreviewbtn' ,to: 'leave_forms#rhpreviewbtn',via: :post
  match 'leave_forms/chpreviewbtn' ,to: 'leave_forms#chpreviewbtn',via: :post
  match 'leave_forms/cancelLeave' ,to: 'leave_forms#cancelLeave',via: :post

  match 'leave_forms/pl_leave' ,to: 'leave_forms#pl_leave',via: :post
  match 'leave_forms/showleaveform' ,to: 'leave_forms#showleaveform',via: :post
  match 'leave_forms/showleaveformcancel' ,to: 'leave_forms#showleaveformcancel',via: :post
  get '/testing/notices/:notiClick' ,to: 'notices#notiClick',as: 'notice_click'
  get 'group/create_group_function',to: 'group#create_group_function'
  get 'group/:groupName' ,to: 'group#group_table',as: 'group_table'
  get 'leave_forms/:data' ,to: 'leave_forms#form',as: 'form_data'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
