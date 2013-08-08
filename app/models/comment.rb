class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_reputation :avg_rating,
    :source => :user,
    :aggregated_by => :average,
    :source_of => [{ :reputation => :review_skill, :of => :user }]

  def content_safe
    content.gsub(/([ ])/)
  end
end
