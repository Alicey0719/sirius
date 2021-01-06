class MembersController < ApplicationController

    def destroy
        
    end

    def show
        @member = Member.find(params[:id])
    end

end
