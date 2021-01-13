class Admin::TagsController < Admin::Base

    #Action
    def index
        @tags = Tag.all
            .order("id")
            .page(params[:page]).per(50)
    end

    def show
        @tag = Tag.find(params[:id])
    end

    def new
        @tag = Tag.new
    end

    def create
        @tag = Tag.new(tagParams)
        if @tag.save then
            redirect_to admin_tag_path(@tag), notice: "タグを作成しました"
        else
            render "new"
        end
    end

    def edit
        @tag = Tag.find(params[:id])
    end
    
    def update
        @tag = Tag.find(params[:id])
        @tag.assign_attributes(tagParams)
        if @tag.save
            redirect_to admin_tag_path(@tag), notice: "タグ情報を更新しました"
        else
            render "edit"
        end
    end

    def destroy
        t = Tag.find(params[:id])
        t.destroy
        redirect_to :admin_tags, notice: "タグを解除しました"
    end

    #Params
    def tagParams
        params.require(:tag).permit(:name)
    end

end