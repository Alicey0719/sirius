class ApplicationController < ActionController::Base

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

end
