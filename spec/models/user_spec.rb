require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    build(:user)
  end

  it "すべてのフォームを入力しているとき登録できること" do
    subject
    expect(subject).to be_valid
  end
  it "ニックネームを入力していないとき登録できないこと" do
    subject.name = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "メールアドレスを入力していないとき登録できないこと" do
    subject.email = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "パスワードを入力していないとき登録できないこと" do
    subject.password = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "重複したメールアドレスが存在するとき登録できないこと" do
    user = create(:user)
    subject.email = user.email
    expect(subject).not_to be_valid
    expect(subject.errors[:email]).to include("はすでに存在します")
  end
  it "passwordが8文字以上であれば登録できること" do
    subject.password = "testuser"
    subject.encrypted_password = "testuser"
    expect(subject).to be_valid
  end

  describe ".guest" do
    it "複数回呼んでも同じゲストユーザーを返すこと" do
      User.where(email: User::GUEST_EMAIL).delete_all

      expect do
        2.times { User.guest }
      end.to change(User, :count).by(1)

      first = User.guest
      second = User.guest
      expect(first.id).to eq(second.id)
    end

    it "ゲストユーザー名が定数どおりであること" do
      User.where(email: User::GUEST_EMAIL).delete_all

      guest = User.guest

      expect(guest.name).to eq(User::GUEST_NAME)
    end
  end

  describe "#image?" do
    it "icon_img未添付のとき空文字を返すこと" do
      expect(subject.image?).to eq("")
    end

    it "画像ファイルのcontent_typeならtrueを返すこと" do
      subject.icon_img.attach(
        io: StringIO.new("dummy"),
        filename: "icon.png",
        content_type: "image/png",
      )

      expect(subject.image?).to eq(true)
    end

    it "jpeg画像でもtrueを返すこと" do
      subject.icon_img.attach(
        io: StringIO.new("dummy"),
        filename: "icon.jpg",
        content_type: "image/jpeg",
      )

      expect(subject.image?).to eq(true)
    end

    it "画像以外のcontent_typeならfalseを返すこと" do
      subject.icon_img.attach(
        io: StringIO.new("dummy"),
        filename: "note.txt",
        content_type: "text/plain",
      )

      expect(subject.image?).to eq(false)
    end

    it "画像以外の添付時にicon_imgのエラーメッセージを持つこと" do
      subject.icon_img.attach(
        io: StringIO.new("dummy"),
        filename: "note.txt",
        content_type: "text/plain",
      )

      subject.valid?

      expect(subject.errors[:icon_img]).to include("は画像データではありません。")
    end
  end

  describe "before_save" do
    it "emailを小文字化して保存すること" do
      user = build(:user, email: "UPPERCASE@EXAMPLE.COM")

      user.save!

      expect(user.reload.email).to eq("uppercase@example.com")
    end

    it "icon_imgを差し替えると新しい添付に更新されること" do
      first_file = StringIO.new("first")
      second_file = Tempfile.new(["second", ".png"])
      second_file.write("second")
      second_file.rewind

      user = create(:user)
      user.icon_img.attach(io: first_file, filename: "first.png", content_type: "image/png")
      first_blob_id = user.icon_img.blob.id

      user.new_icon_img = Rack::Test::UploadedFile.new(
        second_file.path,
        "image/png",
      )
      user.save!

      expect(user.reload.icon_img.blob.id).not_to eq(first_blob_id)
    ensure
      second_file.close!
    end
  end
end
