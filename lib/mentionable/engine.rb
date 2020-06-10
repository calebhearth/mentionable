module Mentionable
  class Engine < ::Rails::Engine
    isolate_namespace Mentionable
    initializer 'mentionable.i18n', before: :load_config_initializers do
      Rails.application.config.i18n.load_path += Dir["#{config.root}/config/locales/**/*.yml"]
    end
  end
end
