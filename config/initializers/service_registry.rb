module Broad
  class ServiceRegistry
    def self.reset
      instance_variables.each do |instance_variable|
        instance_variable_set(instance_variable, nil)
      end
    end

    def self.recommendations
      @recommendations ||= begin
        Services::Trakt::Recommendations.new(token: ::Credential.find_by_name(:trakt).data['access_token'])
      end
    end

    def self.trakt_search
      @trakt_search ||= Services::Trakt::Search.new
    end

    def self.trakt_shows
      @trakt_shows ||= Services::Trakt::Shows.new
    end

    def self.trakt_calendar
      @trakt_calendar ||= Services::Trakt::Calendars.new(token: Credential.find_by_name(:trakt).data['access_token'])
    end

    def self.trakt_user
      @trakt_user ||= Services::Trakt::User.new(token: Credential.find_by_name(:trakt).data['access_token'])
    end

    def self.ptp_api
      @ptp_api ||= Services::PTP::Api.new
    end
  end
end

Rails.application.config.to_prepare do
  Broad::ServiceRegistry.reset
end
