class User < ApplicationRecord
  validates :name, presence: true
  # validates :birthday, presence: true, format: { with: /\A\d{8}\z/,
  #   message: "数字８文字で入力してください" }
end
