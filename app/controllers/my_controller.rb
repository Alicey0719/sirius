class MyController < ApplicationController

    before_action :login_required

    def show
    end

    def info
        @member = current_member
    end

    def edit
    end

    def bkm
    end

    def tickets
    end

    def ticket_his
    end

    def event_his
    end


end
