class Project < ApplicationRecord
  has_many :manages , dependent: :destroy
  has_many :users, through: :manages

  has_many :bugs, dependent: :destroy
  validates :projectname, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :project_description, presence:   true, length: { minimum: 5 }
  validates_format_of :projectname, with: /[a-z][_][a-z]+/, message: ' be like i.e. project_name '
end
