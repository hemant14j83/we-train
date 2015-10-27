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