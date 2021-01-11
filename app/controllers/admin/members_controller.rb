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
        @member = Member.find(params[:id])
    end

    def update
        @member = Member.find(params[:id])
        @member.assign_attributes(usrParams)
        if @member.save
            redirect_to admin_member_path(@member), notice: "ユーザ情報を更新しました。"
        else
            render "edit"
        end
    end

    def destroy
        m = Member.find(params[:id])
        m.destroy
        redirect_to :admin_members, notice: "会員を解除しました"
        #redirect_back(fallback_location: :admin_root, notice: "会員を解除しました")
    end

    #params
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