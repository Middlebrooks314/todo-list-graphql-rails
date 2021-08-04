class Todo < ApplicationRecord
  validates :title, presence: true
  validates :completed, presence: true
  validates :author, presence: true
end
