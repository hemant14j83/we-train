class Notifier < ApplicationMailer

  default :from => 'Traix <hemant14j83@gmail.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.verification.subject
  #
  def newprogram(program)
    @program=program
    mail to: "hemant14j83@gmail.com",  :subject => "New Program -#{@program.name}- added."
  end

  def newprogram_featured(program)
    @program=program
    mail to: "hemant14j83@gmail.com",  :subject => "New Program -#{@program.name}- added."
  end

  def newprogram_urgent(program)
    @program=program
    mail to: "hemant14j83@gmail.com",  :subject => "New Program -#{@program.name}- added."
  end

  def newcontact(contactu)
    @contactu=contactu
    mail to: "hemant14j83@gmail.com",  :subject => "New Message Recieved from contact us page."
  end

  def newcontact_by(contactu)
    @contactu=contactu
    mail to: @contactu.email,  :subject => "#{@contactu.subject} - Traix.in"
  end

  def mailtotrainer(appliedprogram,program,trainer)
    @appliedprogram=appliedprogram
    @program=program
    mail to: @appliedprogram.trainer.email, :subject=>"Your application for #{@program.name}."
  end

  def mailtorecruiter(appliedprogram,program,recruiter)
    @appliedprogram=appliedprogram
    @program=program
    mail to: @program.recruiter.email,
          :subject=>"Your application for #{@program.name}."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.verification_sent.subject
  #
  def send_program_to_trainer(program)
    @program=program
    @greeting = "Hi"

    mail to: "hemant14j83@gmail.com", :subject=> "New requirement matching your profile listed on Traix"
  end
end