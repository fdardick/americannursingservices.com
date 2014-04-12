# Responsible for packaging the resume-attached email
class ResumeMailer < ActionMailer::Base

  def resume(resume_info)

    #recipients ["fdardick@mail.bullhorn.com"]
    @to = ["davidpthomas@gmail.com", "fdardick@americannursingservices.com"]
    #@to = ["davidpthomas@gmail.com"]
    @bcc = ["davidpthomas@gmail.com"]
    @from = 'fdardick@americannursingservices.com'
    @subject = "[Website Resume] #{resume_info.name}"
    @resume_info = resume_info

    # FIXME
    if !resume_info.attachment.nil?
       attachments[resume_info.attachment.original_filename] = resume_info.attachment.read
    end

    mail(to: @to, bcc: @bcc, from: @from, subject: @subject)
  end

end
