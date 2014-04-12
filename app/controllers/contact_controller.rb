class ContactController < ApplicationController
  def index
    @resume_info = ResumeInfo.new
  end

  def submit
    @resume_info = ResumeInfo.new
    @resume_info.name = params[:name]
    @resume_info.email = params[:email]
    @resume_info.phone = params[:phone]
    @resume_info.message = params[:message]
    @resume_info.attachment = params[:attachment]

    # send resume via email
    begin
      ResumeMailer.resume(@resume_info).deliver
    rescue Exception => e
      logger.error "Mail Send Error: #{e.message}"
      flash[:name] = @resume_info.name
      flash[:error] = e.message
      redirect_to :action => "error"
      return
    end
    
    flash[:name] = @resume_info.name
    redirect_to :action => "thanks"
  end

  def thanks
  end

  def error
  end

end
