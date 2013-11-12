class DistributorMailer < ActionMailer::Base
  default from: "JournalBooks <creative@journalbooks.com>"

  def virtual_email(virtual, request, recipients, sender)
    @virtual = virtual
    @request = request
    @recipients = Rails.env.production? ? recipients : "mattr@journalbooks.com"
    @sender = sender
    mail( to: @recipients, 
          from: "#{@sender.name} <#{@sender.email}>",
          subject: "Your virtual no.#{@virtual.id} for #{@request.company} is ready")
  end
end
