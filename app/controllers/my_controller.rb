class MyController < ApplicationController

    before_action :login_required

    def show
    end

    def info
        @member = current_member
    end

    def edit
        @member = current_member
    end

    def update
        @member = current_member
        @member.assign_attributes(usrParams)
        if @member.save
            redirect_to :info_my, notice: "ユーザ情報を更新しました。"
        else
            render "edit"
        end
    end

    def bkm
        @events = current_member.bookmarked_events
            .order("held_at").page(params[:page]).per(15)
    end

    def tickets
    end

    def ticket_his
    end

    def event_his
    end

    #privateMethod
    private def usrParams
        params.require(:update).permit(
            :user_name,
            :full_name,
            :gender,
            :birthday,
            :email,
            :password
        )
    end

end
