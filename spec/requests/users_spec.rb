require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "プロフィールページ" do
    context "プロフィールページが正しく表示されること" do
      before do
        sign_in user
        get users_profile_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end

      it "タイトルが正しく表示されること" do
        expect(response.body).to include('アイコン・ネーム編集 △ TO_CAMP')
      end
    end
  end

  describe "お気に入りページ" do
    context "気になるキャンプ場ページが正しく表示されること" do
      before do
        sign_in user
        get user_path(user)
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end

      it "タイトルが正しく表示されること" do
        expect(response.body).to include('気になるキャンプ場 △ TO_CAMP')
      end
    end
  end

  describe "メール・パスワード編集" do
    context "メール・パスワード編集ページが正しく表示されること" do
      before do
        sign_in user
        get edit_user_registration_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end

      it "タイトルが正しく表示されること" do
        expect(response.body).to include('メール・パスワード編集 △ TO_CAMP')
      end
    end
  end

  describe "新規登録ページ" do
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

  describe "ログインページ" do
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

  describe "パスワード再設定ページ" do
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
end
