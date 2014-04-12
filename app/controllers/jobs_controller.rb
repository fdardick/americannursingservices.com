class JobsController < ApplicationController

  GATEWAY = BullhornGateway.new(File.join(Rails.root, 'data'))

  def index
    @show_industries_sidebar = true
    @job_posts = GATEWAY.job_posts_from_cache.sort
  end

  def show
    @job_post = GATEWAY.job_post(params[:id])
    if @job_post.nil?
      render :action => "index"
      return
    end
    @job_post.description.gsub!(/FONT-SIZE: .*;/,'font-size: 16px;')
  end
end
