class AccountsController < ApplicationController

    def new
        @member = Member.new(birthday: Date.new(2000,1,1))
    end

    def create
        @member = Member.new(usrParams)
        if @member.save then
            cookies.signed[:member_id] = {value:@member.id, expires:10080.minutes.from_now}
            redirect_to :root, notice: "会員登録しました"
        else
            render "new"
        end
    end

    private def usrParams
        params.require(:member).permit(
            :user_name,
            :full_name,
            :gender,
            :birthday,
            :email,
            :password
        )
    end
    
end
