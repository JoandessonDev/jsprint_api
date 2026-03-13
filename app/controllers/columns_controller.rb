class ColumnsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project
    before_action :set_column, only: [:update, :destroy]

    def create
        @column = @project.columns.new(column_params)

        if @column.save
        render json: @column, status: :created
        else
        render json: { errors: @column.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        if @column.update(column_params)
        render json: @column
        else
        render json: { errors: @column.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        @column.destroy
        head :no_content
    end

    private

    def set_project
        @project = current_user.workspaces
                    .joins(:projects)
                    .where(projects: { id: params[:project_id] })
                    .select("projects.*")
                    .first

        head :forbidden unless @project
    end

    def set_column
        @column = @project.columns.find(params[:id])
    end

    def column_params
        params.require(:column).permit(:name)
    end
end