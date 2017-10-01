class Part < ApplicationRecord
  belongs_to :storage
  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    else
      all
    end
  end
end
