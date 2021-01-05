class SessionsController < ApplicationController

    def login
        member = Member.find_by(user_name: params[:user_name])
        if member&.authenticate(params[:password])
            #session[:member_id] = member.id
            cookies.signed[:member_id] = {value:member.id, expires:10080.minutes.from_now}
            redirect_to :root
        else
            flash.alert = "ユーザ名とパスワードが一致しません"
            redirect_to :login
        end
        
    end

    def logout
        #session.delete(:member_id)
        cookies.delete(:member_id)
        redirect_to :root        
    end

    def admin_login 
        admin = Admin.find_by(user_name: params[:user_name])
        if admin&.authenticate(params[:password])
            #session[:admin_id] = admin.id
            cookies.signed[:admin_id] = {value:admin.id, expires:10080.minutes.from_now}
            redirect_to :top_admin
        else
            flash.alert = "ユーザ名とパスワードが一致しません"
            redirect_to :login_admin
        end
        
    end

    def admin_logout
        #session.delete(:admin_id)
        cookies.delete(:admin_id)
        redirect_to :login_admin
    end

end
