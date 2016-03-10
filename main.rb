require_relative 'comment'
require_relative 'post'
require 'nokogiri'
require 'colorize'
require 'open-uri'


def post_details(url)
  raise StandardError, "URL has to be in this format: https://new.ycombinator.com/item?id=######" unless url.match(/https:\/\/news.ycombinator.com\/item\?id\=\d+/)
  html_url = open(url)
  post = Post.new(Nokogiri::HTML(html_url.read))
  puts "Post title: #{post.title}\nNumber of comments: #{post.comments.size}"
  puts "Author: #{post.username.blue}  |  Points: #{post.points.blue}  |  PostID: #{post.item_id.blue}"
  post.comments.each {|comment| puts "\nComment:\n#{comment.text.blue}\n\nUser: #{comment.username.blue} CommentID: #{comment.item_id.blue}\n\n"}
end

post_details(ARGV[0])
