class ProjectsController < ApplicationController
    beore_action :authenticate_user!
    before_action :set_project, only: [:update, :destroy]


    private 

    def set_project
        @project = Project.find(params[:id])
    end

    def project_params
        params.require(:project).permit(:name, :description, :workspace_id)
    end
end
