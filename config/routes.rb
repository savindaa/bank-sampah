Rails.application.routes.draw do
  
  api_version(:module => "V1", :path => {:value => "v1"}) do

    # admin create, login
    post 'secretadmin/signup', to: 'admins#create'
    post 'secretadmin/login', to: 'admin_token#create'
    delete 'secretadmin/delete', to: 'admins#destroy'
    
    # admin block customer or branch
    put 'secretadmin/customer/:phone_number', to: 'customers#blocking'
    put 'secretadmin/branch/:phone_number', to: 'branches#blocking'
    
    # customer index, create, login, profile, update
    get 'customer/index', to: 'customers#index'
    post 'customer/signup', to: 'customers#create'
    post 'customer/login', to: 'customer_token#create'
    get 'customer/profile', to: 'customers#show'
    put 'customer/update', to: 'customers#update'

    # branch index, create, login, profile, update
    get 'branch/index', to: 'branches#index'
    post 'branch/signup', to: 'branches#create'
    post 'branch/login', to: 'branch_token#create'
    get 'branch/profile', to: 'branches#show'
    put 'branch/update', to: 'branches#update'

    # transaction withdraw, deposit
    post 'customer/withdraw', to: 'acct_transactions#withdraw'
    post 'branch/deposit', to: 'acct_transactions#deposit'
    
    # transaction, /v1/acct_transactions/[:id] , :update -> update aprroved from false to true
    resources :acct_transactions, only: [:show, :update, :destroy]

    # jemput sampah, /v1/pick_requests/:id
    resources :pick_requests, only: [:show]

    # showing transaction
    get 'customer/active_transaction', to: 'acct_transactions#customer_transaction_active'
    get 'customer/history_transaction', to: 'acct_transactions#customer_transaction_history'
    get 'branch/active_transaction', to: 'acct_transactions#branch_transaction_active'
    get 'branch/history_transaction', to: 'acct_transactions#branch_transaction_history'

    # showing jemput sampah
    get 'customer/active_pickrequest', to: 'pick_requests#customer_active_pickrequest'
    get 'customer/history_pickrequest', to: 'pick_requests#customer_history_pickrequest'
    get 'branch/active_pickrequest', to: 'pick_requests#branch_active_pickrequest'
    get 'branch/history_pickrequest', to: 'pick_requests#branch_history_pickrequest'

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

    

    # di bawah ini route belum final

    # pick request
    post 'customer/pickrequest', to: 'pick_requests#create'
    put 'branch/pickrequest/:id', to: 'pick_requests#accept'

    
    
  end
end