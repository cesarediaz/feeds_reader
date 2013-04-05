class Channel < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user

  #################################################
  # Validations
  validates :name, :user_id, :presence => true

end
