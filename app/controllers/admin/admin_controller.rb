class Admin::AdminController < Admin::Base

    before_action :admin_login_required, except: [:login]

    #Action
    def login
    end

    def top
    end

    def info
        @admin = current_admin
    end

    def edit
        @admin = current_admin
    end

    def update
        @admin = current_admin
        @admin.assign_attributes(adminParams)
        if @admin.save
            redirect_to :admin_info, notice: "アカウント情報を更新しました。"
        else
            render "edit"
        end
    end

    #strongParams
    private def adminParams
        params.require(:admin).permit(
            :user_name,
            :full_name
        )
    end

end
