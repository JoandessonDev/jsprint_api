class UsersController < ApplicationController
  before_action :set_user, only: [ :update, :destroy ]
  before_action :require_admin, only: [ :destroy ]


  def index
    @users = User.all
    render json: @users
  end

  def update
    perimited_params = current_user.role.name == "admin" ? admin_user_params : user_params

    if @user.update(perimited_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "Usuário deletado com sucesso" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password, :password_confirmation)
  end

  def admin_user_params
  params.require(:user).permit(:name, :email, :cpf, :role_id, :password, :password_confirmation)
end

  def require_admin
    unless current_user.role.name == "admin"
      render json: { error: "Acesso negado" }, status: :forbidden
    end
  end
end
