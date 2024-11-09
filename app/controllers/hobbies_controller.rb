class HobbiesController < ApplicationController
  before_action :set_user

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = current_user.hobbies.build(hobby_params)
    if @hobby.save
      redirect_to user_hobbies_path(@user), notice: "趣味が追加されました"
    else
      render :new, alert: "趣味の追加に失敗しました"
    end
  end

  def index
    @user = User.find(params[:user_id])
    @hobbies = @user.hobbies
  end

  def edit
  end

  def destroy
    @hobby = @user.hobbies.find(params[:id])
    @hobby.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("hobby_#{@hobby.id}") }
      format.html { redirect_to user_hobbies_path(@user), notice: "趣味が削除されました" }
    end
  end

  private

  def hobby_params
    params.require(:hobby).permit(:name, :image)
  end

  def set_user
    @user = current_user
  end
end
