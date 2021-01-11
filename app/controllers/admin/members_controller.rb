class Admin::MembersController < Admin::Base

    def index
        @members = Member.all
            .order("id")
            .page(params[:page]).per(50)
    end

    def show
        @member = Member.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
        m = Member.find(params[:id])
        m.destroy
        redirect_to :admin_members, notice: "会員を解除しました"
        #redirect_back(fallback_location: :admin_root, notice: "会員を解除しました")
    end

end