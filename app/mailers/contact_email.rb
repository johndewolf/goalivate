class ContactEmail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_email.receipt.subject
  #
  def receipt(inquiry)
    @inquiry = inquiry

    mail to: "jdewolf06@gmail.com",
      subject: inquiry.subject,
      content: inquiry.content,
      from: inquiry.email
  end
end
