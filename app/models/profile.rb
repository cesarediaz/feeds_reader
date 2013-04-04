class Profile < ActiveRecord::Base
  attr_accessible :profile_type, :user_id

  belongs_to :user

  #################################################
  # Validations
  validates :profile_type, :presence => true

  attr_accessible :avatar
  has_attached_file :avatar, :styles => {:large => "400x400>", :medium => "200x200>", :thumb => "100x100>" }
  #, :default_url => "/images/:style/missing.png"

end
