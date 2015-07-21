class Story < ActiveRecord::Base
  belongs_to :users
  validates :name, presence: true
  validates :content, presence: true
end