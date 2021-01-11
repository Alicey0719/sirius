class Admin::SessionsController < Admin::Base
  
    def admin_login 
        admin = Admin.find_by(user_name: params[:user_name])
        if admin&.authenticate(params[:password])
            #session[:admin_id] = admin.id
            cookies.signed[:admin_id] = {value:admin.id, expires:10080.minutes.from_now}
            redirect_to :admin_root
        else
            flash.alert = "ユーザ名とパスワードが一致しません"
            redirect_to :admin_login
        end
        
    end

    def admin_logout
        #session.delete(:admin_id)
        cookies.delete(:admin_id)
        redirect_to :admin_login
    end

end
