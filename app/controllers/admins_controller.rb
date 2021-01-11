class AdminsController < ActionController::Base

    before_action :admin_login_required, except: [:login]

    def login
    end

    def top
    end

    def show
    end


    #method
    private def current_admin
        #Admin.find_by(id: session[:admin_id]) if session[:admin_id]
        Admin.find_by(id: cookies.signed[:admin_id]) if cookies.signed[:admin_id]
    end
    helper_method :current_admin

    #login
    class AdminLoginRequired < StandardError; end
    rescue_from AdminLoginRequired, with: :rescue_login_required
    private def admin_login_required
        raise AdminLoginRequired if !current_admin
    end

    #error
    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end

    class Forbidden < StandardError; end

    private def rescue_bad_request(exception)
        render "admins/errors/bad_request", status: 400, layout: "admin_error", formats: [:html]
    end

    private def rescue_login_required(exception)
        render "admins/errors/login_required", status: 403, layout: "admin_error", formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "admins/errors/forbidden", status: 403, layout: "admin_error", formats: [:html]
    end

    private def rescue_not_found(exception)
        render "admins/errors/not_found", status: 404, layout: "admin_error", formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "admins/errors/internal_server_error", status: 500, layout: "admin_error", formats: [:html]
    end

end
