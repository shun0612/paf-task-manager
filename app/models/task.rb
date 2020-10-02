class Task < ApplicationRecord
  validates :task_name, {presence: true}
  validates :deadline, {presence: true}
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
