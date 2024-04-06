# Violation of the Liskov Substitution Principle in Ruby
class UserStatistic
  def initialize(user)
    @user = user
  end

  def posts
    @user.blog.posts
  end
end

class AdminStatistic < UserStatistic
  def posts
    user_posts = super

    string = ''
    user_posts.each do |post|
      string += "title: #{post.title} author: #{post.author}\n" if post.popular?
    end

    string
  end
end

# ------------------------------------------------------------------------------
# Correct use of the Liskov Substitution Principle in Ruby
class UserStatistic
  def initialize(user)
    @user = user
  end

  def posts
    @user.blog.posts
  end
end

class AdminStatistic < UserStatistic
  def posts
    user_posts = super
    user_posts.select { |post| post.popular? }
  end

  def formatted_posts
    posts.map { |post| "title: #{post.title} author: #{post.author}" }.join("\n")
  end
end