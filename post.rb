require_relative 'comment'

class Post

  attr_reader :title, :url, :points, :item_id, :username, :comments
 
  def initialize(url)
    @url = url
    @title = url.search('.title > a:nth-child(2)').inner_text
    @points = url.search('td.subtext > span.score').inner_text
    @item_id = url.search('td.subtext > span.score').attribute('id').to_s[/\d*$/]
    @username = url.search('td.subtext > a:nth-child(2)').inner_text
    @comments = []
    extract_comments
  end

  def extract_comments
    ending_i = "\n                      \n                      -----\n                  \n      ".size
    username_array = url.search('.comment-tree .comhead > a:first-child').map { |element| element.inner_text }
    id_array = url.search('.comment-tree .comhead > .age > a:first-child').map { |element| element['href'].to_s[/\d*$/] }
    text_array = url.search('.comment > span:first-child').map{|comment| comment.inner_text[0..-ending_i-1]}
    arr_size = text_array.size
 
    arr_size.times do |i|
      add_comment(text_array[i], id_array[i], username_array[i])
    end
  end

  # Post#add_comment 
  def add_comment(text, item_id, username)
    comment = Comment.new(text, item_id, username)
    @comments << comment
    comment
  end
end


