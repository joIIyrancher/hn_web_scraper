class Comment

  attr_reader :text, :item_id, :username

  def initialize(text, item_id, username)
    #raise error messages if the parameters are not strings
    raise StandardError, "Invalid text parameter for comment#new" unless text.is_a? String
    raise StandardError, "Invalid item_id parameter for comment#new" unless item_id.is_a? String
    raise StandardError, "Invalid username parameter for comment#new" unless username.is_a? String

    @text = text
    @item_id = item_id
    @username = username
    @comments = []
  end
 
  def comments
    @comments
  end

  def add_comment(text, item_id, username)
    comment = Comment.new(text, item_id, username)
    @comments << comment
    comment
  end
end