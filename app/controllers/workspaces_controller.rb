class WorkspacesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_workspace, only: [:update, :destroy]

    def index 
        @workspaces = current_user.workspaces;
        return render json: @workspaces
    end

    def create
        @workspace = Workspace.new(workspace_params)
        owner_role = WorkspaceRole.find_by(name: "owner")

        WorkspaceMember.create!(
            user: current_user,
            workspace: @workspace,
            workspace_role: owner_role)

        if @workspace.save
            render json: @workspace, status: :created
        else
            render json: { errors: @workspace.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @workspace.update(workspace_params)
        render json: @workspace, status: :ok
        else
        render json: { errors: @workspace.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @workspace.destroy
        head :no_content
    end

    private

    def set_workspace
        @workspace = current_user.workspaces.find(params[:id])
    end

    def workspace_params
        params.require(:workspace).permit(:name, :description)
    end

end
