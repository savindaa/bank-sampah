Rails.application.routes.draw do
  
  api_version(:module => "V1", :path => {:value => "v1"}) do
    
    # customer index, create, login, profile, update
    get 'customer/index', to: 'customers#index'
    post 'customer/signup', to: 'customers#create'
    post 'customer/login', to: 'customer_token#create'
    get 'customer/profile', to: 'customers#show'
    put 'customer/update', to: 'customers#update'
    get 'customer/balance', to: 'customers#show_balance'

    # branch index, create, login, profile, update
    get 'branch/index', to: 'branches#index'
    post 'branch/signup', to: 'branches#create'
    post 'branch/login', to: 'branch_token#create'
    get 'branch/profile', to: 'branches#show'
    put 'branch/update', to: 'branches#update'
    get 'branch/balance', to: 'branches#show_balance'

    # wilayah indonesia
    get 'provinsi', to: 'indonesia#index_province'
    get 'kabupaten', to: 'indonesia#index_regency'
    get 'kecamatan/:regency_code', to: 'indonesia#index_district'
    get 'kelurahan/:district_code', to: 'indonesia#index_village'

    # pricing
    get 'item/price', to: 'items#index'

    # transaction, /v1/acct_transactions/[:id] , :update -> update aprroved from false to true
    resources :acct_transactions, only: [:show, :update]

    # transaction withdraw, deposit
    post 'customer/withdraw', to: 'acct_transactions#withdraw'
    post 'branch/deposit', to: 'acct_transactions#deposit'

    # showing transaction
    get 'customer/active_transaction', to: 'acct_transactions#customer_transaction_active'
    get 'customer/history_transaction', to: 'acct_transactions#customer_transaction_history'
    get 'branch/active_transaction', to: 'acct_transactions#branch_transaction_active'
    get 'branch/history_transaction', to: 'acct_transactions#branch_transaction_history'
    get 'customer/show_deposit', to: 'customers#customer_show_deposit'
    get 'customer/show_withdraw', to: 'customers#customer_show_withdraw'
    get 'branch/show_deposit', to: 'branches#branch_show_deposit'
    get 'branch/show_withdraw', to: 'branches#branch_show_withdraw'

    # jemput sampah, /v1/pick_requests/:id
    resources :pick_requests, only: [:show]

    # pick request
    post 'customer/pickrequest', to: 'pick_requests#create'
    put 'branch/pickrequest/:id', to: 'pick_requests#accept'

    # showing jemput sampah
    get 'customer/active_pickrequest', to: 'pick_requests#customer_active_pickrequest'
    get 'customer/history_pickrequest', to: 'pick_requests#customer_history_pickrequest'
    get 'branch/active_pickrequest', to: 'pick_requests#branch_active_pickrequest'
    get 'branch/history_pickrequest', to: 'pick_requests#branch_history_pickrequest'



    ### di bawah ini belum dipakai ################################

    # voucher, /v1/vouchers(/:id)
    resources :vouchers

    # my voucher
    get 'customer/voucher/all', to: 'my_vouchers#index'
    post 'customer/voucher/new', to: 'my_vouchers#create'
    get 'customer/voucher/:id', to: 'my_vouchers#show'
    put 'customer/voucher/used', to: 'my_vouchers#update'
    delete 'customer/voucher/delete', to: 'my_vouchers#destroy'

    # article (index, show, create, update, destroy)
    resources :articles

    # admin create, login
    post 'secretadmin/signup', to: 'admins#create'
    post 'secretadmin/login', to: 'admin_token#create'
    delete 'secretadmin/delete', to: 'admins#destroy'
    
    # admin block customer or branch
    put 'secretadmin/customer/:phone_number', to: 'customers#blocking'
    put 'secretadmin/branch/:phone_number', to: 'branches#blocking' 
    
    #######################################
  end

  # forest admin route

  namespace :forest do 
      post '/actions/block-customer', to: 'customers#block_customer'
      post '/actions/unblock-customer', to: 'customers#unblock_customer'

      post '/actions/block-branch', to: 'branches#block_branch'
      post '/actions/unblock-branch', to: 'branches#unblock_branch'
  end

  mount ForestLiana::Engine => '/forest'
end