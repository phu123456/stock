class History < ApplicationRecord
  def self.search(search)
    if search
      self.where("plate like ? OR name LIKE ?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
