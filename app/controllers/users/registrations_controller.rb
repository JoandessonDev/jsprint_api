# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # Permitir parâmetros extras (nome e cpf)
  def sign_up_params
    params.require(:user).permit(:name, :cpf, :email, :password, :password_confirmation)
  end

  # Retorno customizado depois do registro
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'User created successfully', user: resource }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end
end