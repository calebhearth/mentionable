module Mentionable
  # Job to verify incoming webmentions that have passed the initial set of
  # verifications (source and target both present, not identical, and are valid
  # URLs).
  #
  # Verifies that the Rails router has a path that matches the target URL's
  # path. If this is the case, pass source and target to
  # {Mentionable.config.persistence_job}, otherwise discard them.
  class VerifyWithRouterJob < ApplicationJob
    queue_as :default

    def perform(source, target)
      if valid_path(target)
        Mentionable.config.persistence_job.perform_later(source, target)
      end
    end

    private

    def valid_path(target)
      Rails.application.routes.recognize_path(target)
    rescue ActionController::RoutingError
      false
    end
  end
end
