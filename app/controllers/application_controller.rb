# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  GATEWAY = BullhornGateway.new(File.join(Rails.root, 'data'))

  before_filter :set_nav_active
  before_filter :load_nav_jobs

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private

  # determines which top-level navigation is selected.  Dynamically
  # sets a class variable based on incoming controller name.  Convention
  # is "{controller_name}_nav_active" e.g. "about_nav_active". The value
  # will set the CSS class of the selected menu item.  In short, this
  # eliminated each controller from having to create redundant code.
  def set_nav_active
    controller_name = params[:controller]
    nav_active_var_name = "#{controller_name}_nav_active"
    self.instance_variable_set("@#{nav_active_var_name}", "active")
  end

  def load_nav_jobs
    @job_posts = GATEWAY.job_posts_from_cache.sort
  end
end
