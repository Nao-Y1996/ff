class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]
	before_action :is_admin?, only: [:change_is_admin]

  def index
  	#@users = User.all
    @users = User.order("term")
    @first = get_1st_grade_term
  end

  def show
  	@user = User.find(params[:id])
    @genre1_name = @user.genre1_name
    @genre2_name = @user.genre2_name

  end

  def edit
  	@user = User.find(params[:id])
  end

  def change_is_admin
  	user = User.find(params[:user_id])
  	if user.is_admin
  		user.is_admin = false
  		user.save
  		redirect_to user_path(user)
  	else
  		user.is_admin = true
  		user.save
  		redirect_to user_path(user)
  	end
  end





  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated profile successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end




  private#----------------------

  def user_params
      params.require(:user).permit(:name, :student_number, :name_kana ,:term, :email)
  end

  def correct_user
	  user = User.find(params[:id])
	  if current_user != user
	   redirect_to user_path(current_user)
	  end
	end



end
