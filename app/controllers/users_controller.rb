class UsersController < ApplicationController

  def show
    @users = User.all
  end

  def new
    # Provide the model instance to the form_for helper
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully signed up!"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, notice: "Account was successfully destroyed."
  end

  private

    # Implement Strong Params
    def user_params
      params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation, :image)
    end

end
