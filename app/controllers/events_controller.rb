class EventsController < ApplicationController

    before_action :login_required, except: [:index, :search, :show]
    before_action :edit_member, only: [:edit, :update]

    def new_1 
    end

    def new_2 
    end

    def index
        @events = Event.order("held_at")
            .page(params[:page]).per(15)
    end

    def search
        @events = Event.search(params[:sword])
            .page(params[:page]).per(15)
        render "index"
    end

    def show
        @event = Event.find(params[:id])
    end

    def edit
        @event = Event.find(params[:id])
    end
    
    def update
    end

    #Method
    #例外処理
    class EventMember < StandardError; end
    rescue_from EventMember, with: :rescue_forbidden
    private def edit_member
        if Event.find(params[:id]).member == current_member then
            return current_member
        else
            raise EventMember
        end
    end


end
