# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: "Login realizado com sucesso",
      user: {
        id: resource.id,
        email: resource.email,
        name: resource.name
      },
      token: request.env["warden-jwt_auth.token"]
    }, status: :ok
  end

  def respond_to_on_destroy(resource_or_scope = nil)
    render json: { message: "Logout realizado com sucesso" }, status: :ok
  end
end
