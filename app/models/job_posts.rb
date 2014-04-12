# Collection class to manage a list of job posts.
class JobPosts
  def initialize
    @job_posts = Array.new
  end

  def <<(job)
    @job_posts.push(job)
  end

  def [](index)
    @job_posts[index]
  end

  def size
    @job_posts.size
  end

  include Enumerable

  def each
    @job_posts.each do |job|
      yield job
    end
  end

end
