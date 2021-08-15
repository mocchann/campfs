class HomeController < ApplicationController
  def top
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      flash[:notice] = "お問い合わせを送信しました。TO_CAMPのご利用ありがとうございます。"
      redirect_to root_path
    else
      flash[:alert] = "お問い合わせを送信できませんでした。フォームの空欄を入力して下さい"
      redirect_to root_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :message)
  end
end
