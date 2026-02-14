require 'rails_helper'

RSpec.describe "UserAuthentications", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end

    context 'パラメータが適正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end
      it 'createが成功すること' do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end
      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end
      it 'createが失敗すること' do
        expect do
          post user_registration_path, params: { user: invalid_user_params }
        end.not_to change(User, :count)
      end
      it 'エラーが表示されること' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include '1 件の入力ミスがあります。下記項目の修正をお願いします。'
      end
    end
  end

  describe "POST /users/sign_in" do
    before { user }

    it "正しい認証情報でログインできること" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }

      expect(response).to redirect_to(root_path)
    end

    it "メールアドレスが不正だとログインできないこと" do
      post user_session_path, params: { user: { email: "invalid@example.com", password: user.password } }

      expect(response.status).to eq(200)
      expect(response.body).to include("メールアドレスまたはパスワードが違います。")
    end

    it "パスワードが不正だとログインできないこと" do
      post user_session_path, params: { user: { email: user.email, password: "invalid_password" } }

      expect(response.status).to eq(200)
      expect(response.body).to include("メールアドレスまたはパスワードが違います。")
    end

    it "パスワードが空だとログインできないこと" do
      post user_session_path, params: { user: { email: user.email, password: "" } }

      expect(response.status).to eq(200)
      expect(response.body).to include("メールアドレスまたはパスワードが違います。")
    end
  end

  describe "DELETE /users/sign_out" do
    before { sign_in user }

    it "ログアウトしてトップページにリダイレクトすること" do
      delete destroy_user_session_path

      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /users/password" do
    before { ActionMailer::Base.deliveries.clear }

    it "登録済みメールアドレスなら再設定メールを送信できること" do
      post user_password_path, params: { user: { email: user.email } }

      expect(response).to redirect_to(new_user_session_path)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      mail_body = ActionMailer::Base.deliveries.last.body.encoded
      expect(mail_body).to include("reset_password_token")
    end

    it "ゲストメールは再設定不可でメール送信しないこと" do
      post user_password_path, params: { user: { email: User::GUEST_EMAIL } }

      expect(response).to redirect_to(new_user_session_path)
      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end

    it "有効なトークンでパスワード再設定できること" do
      token = user.send_reset_password_instructions

      put user_password_path, params: {
        user: {
          reset_password_token: token,
          password: "newpassword1",
          password_confirmation: "newpassword1",
        },
      }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "無効なトークンではパスワード再設定できないこと" do
      put user_password_path, params: {
        user: {
          reset_password_token: "invalid-token",
          password: "newpassword1",
          password_confirmation: "newpassword1",
        },
      }

      expect(response.status).to eq(200)
      expect(response.body).to include("新規パスワード入力")
    end
  end

  describe "POST /users/guest_sign_in" do
    it "複数回実行してもゲストユーザーを使い回すこと" do
      User.where(email: User::GUEST_EMAIL).delete_all

      expect do
        2.times { post users_guest_sign_in_path }
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(root_path)
    end
  end
end
