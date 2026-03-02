class ApplicationController < ActionController::API
    def current_user
        @current_user ||= super
    end
end
