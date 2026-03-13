class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: [:update, :destroy]

    def index
        workspace = Workspace.find(params[:workspace_id])
        @projects = workspace.projects
        render json: @projects, only: [:id, :name, :description]
    end

    def create
        @project = Project.new(project_params)
        if @project.save
            create_default_columns(@project)
            render json: @project, status: :created
        else
            render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @project.update(project_params)
            render json: @project
        else
            render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @project.destroy()
        head :no_content
    end


    private 

    def set_project
        @project = Project.find(params[:id])
    end

    def project_params
        params.require(:project).permit(:name, :description, :workspace_id)
    end

    def create_default_columns(project)
        default_column_names = ["To Do", "In Progress", "In Analysis", "Done"]
        default_column_names.each do |name|
            Column.create!(name: name, project: project)
        end
    end
end
