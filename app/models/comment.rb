class Comment < ActiveRecord::Base
  paginates_per 15
  attr_accessible :content, :user_id, :article_id

  belongs_to :user
  belongs_to :article

  #################################################
  # Validations
  validates :content, :article_id, :user_id, :presence => true
end
