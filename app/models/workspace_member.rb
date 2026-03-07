class WorkspaceMember < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :workspace_role
end
