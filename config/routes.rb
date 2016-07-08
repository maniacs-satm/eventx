Rails.application.routes.draw do
  root "welcome#index"
  get "events/new"
  post "/events/:event_id/manage_staffs" => "manager_profiles#save_staffs",
       as: :save_staffs
  get "/events/:event_id/manage_staffs" => "manager_profiles#manage_staffs",
      as: :manage_staffs
  get "/events/:event_id/remove_staff/:event_staff_id" =>
    "manager_profiles#remove_staff", as: :remove_staff
  get "/events/:id/enable" =>
          "events#enable", as: :enable_event
  get "/events/:id/disable" =>
          "events#disable", as: :disable_event
  get "/events/:id/generate" => "events#generate", as: :generate_event
  get "/featured_events" => "welcome#featured"
  get "/popular_events" => "welcome#popular"
  match "/events/popular" => "events#popular", via: [:post, :get]
  get "/upcoming_events" => "welcome#index"
  get "/my_events" => "users#show"
  get "events/loading"
  get "/lookup_staffs" => "users#lookup_staff_emails"
  get "/user_info/:user_id" => "users#fetch_user_info"
  post "/refund/:uniq_id" => "bookings#request_refund", as: :refund
  post "/paypal_hook" => "bookings#paypal_hook", as: :paypal_hook
  get "/scan_ticket" => "bookings#scan_ticket", as: :scan_ticket
  get "/events/:id/scan" => "events#scan", as: :gatekeeper
  get "/scan_ticket/:ticket_no" => "bookings#use_ticket", as: :scan
  get "unattend", to: "attendees#destroy", as: "unattend"
  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")

  scope controller: :bookings do
    get "/bookings" => :index
    get "/bookings/:id/tickets" => :all_tickets, as: :all_tickets
  end

  resources :ticket_transactions

  scope controller: :ticket_transactions do
    get "/bookings/:id/ticket-transactions" => :index, as: :booking_tickets
    get "/ticket_transactions/:id/checkout" => :checkout_ticket, as: :checkout
    post "/ticket_transaction_hook" => :hook, as: :ticket_transaction_hook
  end

  get "/events/:id/tickets" => "events#tickets", as: :event_tickets
  get "/events/:id/tickets-report" =>
          "events#tickets_report", as: :tickets_report
  get "/print/:booking_id(/:ticket_type_id)" => "printer#print", as: :print
  post "/print/:id" => "printer#redirect_to_print"
  get "/print/:id" => "printer#redirect_to_print"
  get "/download/:booking_id" => "printer#download", as: :download
  get "signout", to: "sessions#destroy", as: "signout"
  get "/session" => "sessions#create"
  post "/api_login" => "sessions#api_login"
  resources :manager_profiles, only: [:new, :create]
  resources :attendees
  resources :categories
  resources :events do
    resources :bookings, only: [:create]
    resources :sponsors
  end
  get "/remit/:id", to: "remit#new", as: :remit
  resources :users, only: [:show]
  get "*unmatched_route", to: "application#no_route_found"
end
