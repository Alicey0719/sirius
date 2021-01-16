class Admin::PasswordsController < Admin::Base

    before_action :login_required

    def edit
        @admin = current_admin
    end

    def update
        @admin = current_admin
        current_password = pwParam[:current_password]
        
        if current_password.present?
            if @admin.authenticate(current_password)
                @admin.assign_attributes(pwParam)
                if @admin.save
                    redirect_to :admin_info, notice: "パスワードを変更しました。"
                else
                    render "edit"
                end
            else
                @admin.errors.add(:current_password, :wrong)
                render "edit"
            end
        else
            @admin.errors.add(:current_password, :empty)
            render "edit"
        end
    end

    #Method
    private def pwParam
        params.require(:pwedit).permit(
            :current_password,
            :password,
            :password_confirmation
        )
    end

end
