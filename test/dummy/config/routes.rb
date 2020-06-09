Rails.application.routes.draw do
  mount Mentionable::Engine => "/"
  root to: "application#index"
end
