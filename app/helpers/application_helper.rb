module ApplicationHelper
  
  def body_class(klass)
    content_for(:body_class) do
      klass
    end    
  end

  def body_id(id)
    content_for(:body_id) do
      id
    end
  end
end

