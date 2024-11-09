class ProfilesController < ApplicationController
  def show
    @user = current_user
    @hobbies = @user.hobbies
  end

  def edit
  end

  def update
  end
end
