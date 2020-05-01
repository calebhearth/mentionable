Mentionable::Engine.routes.draw do
  post "/webmention", to: "mentions#create", as: :mentions
end
