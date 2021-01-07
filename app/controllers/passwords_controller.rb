class PasswordsController < ApplicationController

    before_action :login_required

    def edit
        @member = current_member
    end

    def update
        @member = current_member
        current_password = pwParam[:current_password]

        if current_password.present?
            if @member.authenticate(current_password)
                @member.assign_attributes(pwParam)
                if @member.save
                    redirect_to :info_my, notice: "パスワードを変更しました。"
                else
                    render "edit"
                end
            else
                @member.errors.add(:current_password, :wrong)
                render "edit"
            end
        else
            @member.errors.add(:current_password, :empty)
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
