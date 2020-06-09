require_dependency "mentionable/application_controller"

module Mentionable
  class MentionsController < ApplicationController
    def create
      source = URI(params.fetch(:source) { missing_source_or_target; return })
      target = URI(params.fetch(:target) { missing_source_or_target; return })

      if source == target
        render(
          plain: "source URL cannot be the same as target URL",
          status: :bad_request,
        )
        return
      end

      [source, target].each do |uri|
        if !%w(http https).include? uri.scheme
          render(
            plain: "#{uri} is not a valid URL. Please use http:// or https://",
            status: :bad_request,
          )
          return
        end
      end

      Mentionable.config.verification_job.perform_later(source.to_s, target.to_s)

      head :accepted
    end

    private

    def missing_source_or_target
      render(
        plain: "source and target params are required and must be HTTP or HTTPS URLs",
        status: :bad_request,
      )
    end
  end
end
