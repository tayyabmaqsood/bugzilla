class User < ApplicationRecord
  has_many :manages
  has_many :projects, through: :manages, dependent: :destroy

  has_many :reports
  has_many :bugs, through: :reports, dependent: :destroy

  validates :username, presence: true, length: { minimum: 3 }
  validates :user_type, inclusion: { in: [ 'qa', 'developer', 'manager' ], message: 'please select from given list' }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
