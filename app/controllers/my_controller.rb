class MyController < ApplicationController

    before_action :login_required

    def show
        @rank = member_rank(member_reputation(current_member))        
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
        t_ids = []
        current_member.tickets.each do |t|
            if t.event.held_at >= Date.today then
                t_ids.push(t.id)
            end
        end
        
        @tickets = Ticket.where(id: t_ids)
            .order("created_at").page(params[:page]).per(15)
        
    end

    def ticket_his
        @tickets = current_member.tickets
            .order("created_at").page(params[:page]).per(15)
    end

    def tickets_stat
        @events = current_member.events.where('held_at >= ?', Date.today)
            .order("held_at").page(params[:page]).per(15)
    end

    def event_his
        @events = current_member.events
            .order("held_at").page(params[:page]).per(15)
    end

    #privateMethod
    private def usrParams
        params.require(:update).permit(
            :user_name,
            :full_name,
            :gender,
            :birthday,
            :email
        )
    end

end
