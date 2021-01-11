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
end
