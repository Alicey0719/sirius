class Admin::AdminController < Admin::Base

    before_action :admin_login_required, except: [:login]

    #Action
    def login
    end

    def top
    end

end
