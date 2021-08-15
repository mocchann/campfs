class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      flash[:notice] = "お問い合わせを送信しました。TO_CAMPのご利用ありがとうございます。"
      redirect_to root_path
    else
      flash[:danger] = "お問い合わせを送信できませんでした。フォームの空欄を正しく入力して下さい"
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
