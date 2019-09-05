class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    user_name = params[:user_name]
    department_name = params[:department_name]
    @users = User.all
    @users = @users.where('name like ?', "%#{user_name}%") if user_name
    departments = Department.where('departments.name like ?',
                                   "%#{department_name}%")
    @users = @users.where(department: departments)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    case params[:by]
    when 'update_password'
      render :password
    else
      render :form
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    case params[:by]
    when 'update_password'
      update_password
    else
      if @user.update(user_params)
        redirect_to users_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def update_password
    @page_title = '修改个人密码'
    if current_user.update_with_password(user_params)
      redirect_to root_path, notice: '密码更新成功，现在你需要重新登陆。'
    else
      render 'password'
    end
  end

  def user_params
    params.require(:user).permit(*User::ACCESSIBLE_ATTRS)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
