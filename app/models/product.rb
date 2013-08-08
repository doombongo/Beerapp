class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image
  has_many :comments, as: :commentable
  belongs_to :user
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  has_reputation :votes, :source => :user
end
