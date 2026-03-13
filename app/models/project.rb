class Project < ApplicationRecord
  belongs_to :workspace
  has_many :columns, dependent: :destroy
end
