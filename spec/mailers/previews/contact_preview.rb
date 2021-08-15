# Preview all emails at http://localhost:3000/rails/mailers/contact
class ContactPreview < ActionMailer::Preview
  def contact
    contact = Contact.new(name: "伝説のキャンパー", message: "問い合わせメッセージ")
    ContactMailer.send_mail(contact)
  end
end
