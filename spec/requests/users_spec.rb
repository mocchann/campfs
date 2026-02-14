require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET users#profile" do
    subject do
      get users_profile_path
    end

    context "ユーザーがログインしているとき" do
      before do
        sign_in user
      end

      it "リクエストが200 OKとなること" do
        subject
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        subject
        expect(response.body).to include('アイコン・ネーム編集 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページに遷移すること" do
        subject
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET users#show" do
    subject do
      get user_path(user)
    end

    context "ユーザーがログインしているとき" do
      before do
        sign_in user
      end

      it "リクエストが200 OKとなること" do
        subject
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        subject
        expect(response.body).to include('気になるキャンプ場 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページに遷移すること" do
        subject
        expect(response.status).to eq 302
      end
    end

    context "他ユーザーのブックマーク一覧を表示するとき" do
      let(:other_user) { create(:user) }
      let(:bookmarked_field) { create(:field, name: "他ユーザーのブックマーク") }

      before do
        create(:bookmark, user: other_user, field: bookmarked_field)
        sign_in user
        get user_path(other_user)
      end

      it "他ユーザーのブックマークを表示できること" do
        expect(response.status).to eq(200)
        expect(response.body).to include("他ユーザーのブックマーク")
      end
    end

    context "存在しないidを指定したとき" do
      before { sign_in user }

      it "ActiveRecord::RecordNotFoundになること" do
        expect do
          get user_path(999_999_999)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET users/registrations#edit" do
    subject do
      get edit_user_registration_path
    end

    context "メール・パスワード編集ページが正しく表示されること" do
      before do
        sign_in user
      end

      it "リクエストが200 OKとなること" do
        subject
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        subject
        expect(response.body).to include('メール・パスワード編集 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページに遷移すること" do
        subject
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET users/registrations#new" do
    context "新規登録ページが正しく表示されること" do
      before do
        get new_user_registration_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('新規登録 △ TO_CAMP')
      end
    end
  end

  describe "GET devise/sessions#new" do
    context "ログインページが正しく表示されること" do
      before do
        get new_user_session_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('ログイン △ TO_CAMP')
      end
    end
  end

  describe "GET users/passwords#new" do
    context "パスワード再設定ページが正しく表示されること" do
      before do
        get new_user_password_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('パスワード再設定 △ TO_CAMP')
      end
    end
  end

  describe "POST users/sessions#guest_sign_in" do
    it "ゲストユーザーでログインしてトップにリダイレクトすること" do
      post users_guest_sign_in_path

      expect(response).to redirect_to(root_path)
      expect(User.find_by(email: User::GUEST_EMAIL)).to be_present
    end
  end

  describe "PATCH users#profile_update" do
    let(:valid_params) do
      {
        id: user.id,
        user: {
          name: "updated_name",
        },
      }
    end

    let(:invalid_params) do
      {
        id: user.id,
        user: {
          name: "",
        },
      }
    end

    let(:invalid_email_params) do
      {
        id: user.id,
        user: {
          email: "invalid_email",
        },
      }
    end

    let(:invalid_password_params) do
      {
        id: user.id,
        user: {
          password: "123",
        },
      }
    end

    let(:duplicate_email_params) do
      {
        id: user.id,
        user: {
          email: existing_user.email,
        },
      }
    end

    let(:uppercase_email_params) do
      {
        id: user.id,
        user: {
          email: "NEWMAIL@EXAMPLE.COM",
        },
      }
    end

    context "通常ユーザーがログインしているとき" do
      before { sign_in user }
      let!(:existing_user) { create(:user) }
      let!(:other_user_for_update) { create(:user) }

      it "有効なパラメータでプロフィール更新できること" do
        patch users_profile_update_path, params: valid_params

        expect(response).to redirect_to(users_profile_path)
        expect(user.reload.name).to eq("updated_name")
      end

      it "不正なパラメータでは更新できずprofileを再描画すること" do
        patch users_profile_update_path, params: invalid_params

        expect(response.status).to eq 200
        expect(user.reload.name).not_to eq("")
      end

      it "不正なemailでは更新できないこと" do
        patch users_profile_update_path, params: invalid_email_params

        expect(response.status).to eq(200)
        expect(user.reload.email).not_to eq("invalid_email")
      end

      it "短すぎるpasswordでは更新できないこと" do
        patch users_profile_update_path, params: invalid_password_params

        expect(response.status).to eq(200)
      end

      it "既存ユーザーと重複するemailでは更新できないこと" do
        patch users_profile_update_path, params: duplicate_email_params

        expect(response.status).to eq(200)
        expect(user.reload.email).not_to eq(existing_user.email)
      end

      it "大文字emailで更新しても小文字化して保存されること" do
        patch users_profile_update_path, params: uppercase_email_params

        expect(response).to redirect_to(users_profile_path)
        expect(user.reload.email).to eq("newmail@example.com")
      end

      it "画像ファイルを添付して更新できること" do
        image_file = Tempfile.new(["icon", ".png"])
        image_file.write("dummy image")
        image_file.rewind

        params = {
          id: user.id,
          user: {
            name: "icon_updated_user",
            new_icon_img: Rack::Test::UploadedFile.new(image_file.path, "image/png"),
          },
        }

        patch users_profile_update_path, params: params

        expect(response).to redirect_to(users_profile_path)
        expect(user.reload.icon_img).to be_attached
      ensure
        image_file.close!
      end

      it "画像以外を添付すると更新できないこと" do
        text_file = Tempfile.new(["icon", ".txt"])
        text_file.write("dummy text")
        text_file.rewind

        params = {
          id: user.id,
          user: {
            new_icon_img: Rack::Test::UploadedFile.new(text_file.path, "text/plain"),
          },
        }

        patch users_profile_update_path, params: params

        expect(response.status).to eq(200)
      ensure
        text_file.close!
      end

      it "他ユーザーidを送ってもcurrent_userのみ更新されること" do
        patch users_profile_update_path, params: {
          id: other_user_for_update.id,
          user: { name: "attacked_name" },
        }

        expect(response).to redirect_to(users_profile_path)
        expect(user.reload.name).to eq("attacked_name")
        expect(other_user_for_update.reload.name).not_to eq("attacked_name")
      end
    end

    context "ログインしていないとき" do
      it "ログインページにリダイレクトすること" do
        patch users_profile_update_path, params: valid_params

        expect(response).to redirect_to(new_user_session_path)
      end

      it "userパラメータがなくても先にログインページへ遷移すること" do
        patch users_profile_update_path, params: { id: user.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ゲストユーザーがログインしているとき" do
      let(:user) { User.guest }

      before { sign_in user }

      it "トップページにリダイレクトされること" do
        patch users_profile_update_path, params: valid_params

        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to include("編集・削除などができない")
      end

      it "更新パラメータを送ってもプロフィールが変更されないこと" do
        before_name = user.name
        before_email = user.email
        before_encrypted_password = user.encrypted_password

        patch users_profile_update_path, params: {
          id: user.id,
          user: { name: "hacked_name", email: "hacked@example.com", password: "newpassword" },
        }

        user.reload
        expect(user.name).to eq(before_name)
        expect(user.email).to eq(before_email)
        expect(user.encrypted_password).to eq(before_encrypted_password)
      end
    end

    context "通常ユーザーがログインしていてuserパラメータがないとき" do
      before { sign_in user }

      it "ActionController::ParameterMissingになること" do
        expect do
          patch users_profile_update_path, params: { id: user.id }
        end.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "POST users/passwords#create" do
    it "ゲストユーザーのメールではログインページにリダイレクトすること" do
      post user_password_path, params: { user: { email: User::GUEST_EMAIL } }

      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to eq("ゲストユーザーさんのパスワードは再設定できません。")
    end
  end
end
