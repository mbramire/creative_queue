class DistributorMailer < ActionMailer::Base
  default from: "JournalBooks <creative@journalbooks.com>"

  def virtual_email(virtual, request, recipients, sender)
    @virtual = virtual
    @request = request
    @recipients = Rails.env.production? ? recipients : "mattr@journalbooks.com"
    @sender = sender
    attachments["virtual_#{@request.quote}_ver#{@virtual.version}.pdf"] = File.read(Rails.root.join(@virtual.document.path))
    mail( to: @recipients, 
          from: "#{@sender.name} <#{@sender.email}>",
          subject: "Your virtual no.#{@request.quote}#{@virtual.version_display} for #{@request.end_client} is ready")
  end
end