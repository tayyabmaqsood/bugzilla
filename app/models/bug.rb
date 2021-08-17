class Bug < ApplicationRecord
  belongs_to :project
  has_one_attached :screenshot

  has_many :reports, dependent: :destroy
  has_many :users, through: :report

  # validates :screenshot, allow_blank: true, presence: false, format: {
  #                                            with: %r{ \.gif|png }i,
  #                                            message: 'Image formate must be in gif or png'
  # }
  validates :title, presence: true, uniqueness: true
  validates :bug_type, presence: true, length: { minimum: 2, message: 'Select bug type' }
end
