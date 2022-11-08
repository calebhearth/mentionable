Rails.application.routes.draw do
  mount Mentionable::Engine, at: "/"
  root to: "application#index"
end
