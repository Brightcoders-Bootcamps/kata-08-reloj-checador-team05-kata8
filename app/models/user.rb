class User < ApplicationRecord
  has_many :checks
  belongs_to :company
end
