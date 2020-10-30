class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}

  def tasks
    if $sort == "created_at" && $search == "uncomplete"
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 0).order(:created_at)
    elsif $sort == "created_at" && $search == "completed"
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 1).order(:created_at)
    elsif $sort == "created_at" && $search == "all"
      return Task.where(user_id: self.id, delete_flg: 0).order(:created_at)
    elsif $sort == "priority" && $search == "uncomplete"
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 0).order(priority: "DESC")
    elsif $sort == "priority" && $search == "completed"
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 1).order(priority: "DESC")
    elsif $sort == "priority" && $search == "all"
      return Task.where(user_id: self.id, delete_flg: 0).order(priority: "DESC")
    elsif $sort == "deadline" && $search == "completed"
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 1).order(:deadline)
    elsif $sort == "deadline" && $search == "all"
      return Task.where(user_id: self.id, delete_flg: 0).order(:deadline)
    else
      return Task.where(user_id: self.id, delete_flg: 0, complete_flg: 0).order(:deadline)
    end
  end

  def self.find_or_create_from_auth(auth)
    name = auth[:info][:name]
    nickname = "@" + auth[:info][:nickname]
    password = "admin"

    self.find_or_create_by(email: nickname, password: password) do |user|
      user.name = name
      user.email = "@" + nickname
      user.password = "admin"
    end
  end

end
