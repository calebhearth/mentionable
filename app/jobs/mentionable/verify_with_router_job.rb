module Mentionable
  # Job to verify incoming webmentions that have passed the initial set of
  # verifications (source and target both present, not identical, and are valid
  # URLs).
  #
  # Verifies that the Rails router has a path that matches the target URL's
  # path. Pass source, target, and validity to
  # {Mentionable::Configuration#persistence_job
  # Mentionable.config.persistence_job}.
  class VerifyWithRouterJob < ApplicationJob
    queue_as :default

    def perform(source, target)
      Mentionable.config.persistence_job
        .perform_later(source:, target:, valid: valid_path(target))
    end

    private

    def valid_path(target)
      Rails.application.routes.recognize_path(target)
      true
    rescue ActionController::RoutingError
      false
    end
  end
end
