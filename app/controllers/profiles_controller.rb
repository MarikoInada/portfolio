class ProfilesController < ApplicationController
  before_action :set_user
  before_action :set_user_profile, only: [:edit, :update]

  def show
    @profile = @user.profile || @user.build_profile # プロフィールがない場合は新規作成
    @hobbies = @user.hobbies
  end

  def edit
    @profile = @user.profile || current_user.build_profile
  end

  def update
    if @user.update(user_params) && @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: 'プロフィールが更新されました。'
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_profile
    @user = current_user
    @profile = @user.profile || @user.build_profile # プロフィールがない場合は新規作成
  end

  def profile_params
    params.require(:profile).permit(:interest, :strength, :hobby)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:profile).permit(:name, :email, :image)
  end
end
