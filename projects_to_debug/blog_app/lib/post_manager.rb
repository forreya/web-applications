class PostManager
  def self.instance
    @instance ||= self.new
  end

  def initialize
    @posts = []
  end

  def add_post(post)
    @posts.push(post)
  end

  def all_posts
    @posts
  end

  def all_posts_by_tag(tag)
    tagged_posts = @posts.select do |post|
      post.tags.include?(tag)
    end

    tagged_posts
  end
end