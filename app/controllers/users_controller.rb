class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :update, :destroy ]
  before_action :require_admin, only: [ :destroy ]

  def index
    @users = User.select(:id, :name, :email, :cpf, :role_id)
    render json: @users
  end

  def update
    unless admin? || current_user.id == @user.id
      render json: { error: "Acesso negado" }, status: :forbidden and return
    end

    permitted_params = admin? ? admin_user_params : user_params

    if @user.update(permitted_params)
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

  def admin?
    current_user.role.name == "admin"
  end

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "Usuário não encontrado" }, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password, :password_confirmation)
  end

  def admin_user_params
    params.require(:user).permit(:name, :email, :cpf, :role_id, :password, :password_confirmation)
  end

  def require_admin
    unless admin?
      render json: { error: "Acesso negado" }, status: :forbidden
      nil
    end
  end
end
