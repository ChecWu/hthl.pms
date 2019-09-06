class RolesController < ApplicationController
  def index
    name = params[:name]
    @roles = Role.all
    @roles = @roles.where('name like ? ', "%#{name}%") if name.present?
    @roles = @roles.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to roles_path
  end

  def role_permission
  end

  private
  def role_params
    params.require(:role).permit(:type, :name, :explain, :status)
  end
end
