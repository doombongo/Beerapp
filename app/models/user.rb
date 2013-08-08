class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :name, :password, :password_confirmation, :image
  validates_uniqueness_of :name
  mount_uploader :image, ImageUploader

  has_many :evaluations, class_name: "RSEvaluation", as: :source
  has_many :products
  has_many :reviews
  has_many :comments, as: :commentable

  # has_reputation :rat,
  #   :source => [{ :reputation => :questioning_skill, :weight => 0.8 },
  #           { :reputation => :answering_skill}]

  # has_reputation :product_reputation, 
  # :source => {:reputation => :votes, :of => :products}

  # has_reputation :review_reputation, 
  # :source => { :reputation => :avg_rating, :of => :review }
  
  def voted_for?(product)
    evaluations.where(target_type: product.class, target_id: product.id).present?
  end  
  
end
