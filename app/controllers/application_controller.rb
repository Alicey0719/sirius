class ApplicationController < ActionController::Base

    #Define
    PLATINUM = 30
    GOLD = 20
    SILVER = 10
    BRONZE = 5
    STANDARD = 0

    #currentUserMethod
    private def current_member
        #Member.find_by(id: session[:member_id]) if session[:member_id]
        Member.find_by(id: cookies.signed[:member_id]) if cookies.signed[:member_id]
    end
    helper_method :current_member

    private def current_admin
        #Admin.find_by(id: session[:admin_id]) if session[:admin_id]
        Admin.find_by(id: cookies.signed[:admin_id]) if cookies.signed[:admin_id]
    end
    helper_method :current_admin

    #Method
    private def member_reputation(member)
        rank = 0
        begin
            member.events.each do |e|
                rank += e.reputations.count
            end
        rescue => error
        end
        return rank
    end
    helper_method :member_reputation

    private def member_rank(member_rep)
        v = 0
        if member_rep < BRONZE then
            v = 0
        elsif member_rep < SILVER then
            v = 1
        elsif member_rep < GOLD then
            v = 2
        elsif member_rep < PLATINUM then
            v = 3
        elsif member_rep >= PLATINUM then
            v = 4
        end
        return v
    end
    helper_method :member_rank

    #login
    class LoginRequired < StandardError; end
    rescue_from LoginRequired, with: :rescue_login_required
    private def login_required
        raise LoginRequired if !current_member
    end

    #error
    if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
        rescue_from StandardError, with: :rescue_internal_server_error
        rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
        rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
    end

    class Forbidden < StandardError; end

    private def rescue_bad_request(exception)
        render "errors/bad_request", status: 400, layout: "error", formats: [:html]
    end

    private def rescue_login_required(exception)
        render "errors/login_required", status: 403, layout: "error", formats: [:html]
    end

    private def rescue_forbidden(exception)
        render "errors/forbidden", status: 403, layout: "error", formats: [:html]
    end

    private def rescue_not_found(exception)
        render "errors/not_found", status: 404, layout: "error", formats: [:html]
    end

    private def rescue_internal_server_error(exception)
        render "errors/internal_server_error", status: 500, layout: "error", formats: [:html]
    end

end
