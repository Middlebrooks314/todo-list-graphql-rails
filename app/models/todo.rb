class Todo < ApplicationRecord
  validates :title, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validates :author, presence: true
end
