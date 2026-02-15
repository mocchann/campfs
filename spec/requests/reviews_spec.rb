require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:field) { create(:field) }

  describe "GET reviews#new" do
    context "ユーザーがログインしているとき" do
      before do
        sign_in user
        get search_fields_path
        get field_path(field)
        get new_review_path, params: { field_id: field.id }
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('口コミ投稿 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      before do
        get search_fields_path
        get field_path(field)
        get new_review_path, params: { field_id: field.id }
      end

      it "ログインページに遷移すること" do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST reviews#create" do
    let(:review_params) do
      {
        review: {
          title: "とても良いキャンプ場",
          content: "景色が良く設備も整っている",
          rate: 4.5,
        },
        field_id: field.id,
      }
    end

    context "ユーザーがログインしているとき" do
      before { sign_in user }

      it "口コミを作成してキャンプ場詳細へリダイレクトすること" do
        expect do
          post reviews_path, params: review_params
        end.to change(Review, :count).by(1)

        expect(response).to redirect_to(field_path(field))
        expect(flash[:notice]).to eq("口コミを投稿しました。")
      end

      it "不正なパラメータでは作成に失敗してnewを再描画すること" do
        invalid_params = review_params.deep_dup
        invalid_params[:review][:title] = ""

        expect do
          post reviews_path, params: invalid_params
        end.not_to change(Review, :count)

        expect(response.status).to eq(200)
        expect(flash[:danger]).to be_present
        expect(response.body).to include("口コミの投稿に失敗しました。空欄を埋めて下さい。")
        expect(response.body).to include("口コミ投稿")
      end

      it "rateが未入力だと作成に失敗すること" do
        invalid_params = review_params.deep_dup
        invalid_params[:review][:rate] = nil

        expect do
          post reviews_path, params: invalid_params
        end.not_to change(Review, :count)

        expect(response.status).to eq(200)
      end

      it "rateが範囲外だと作成に失敗すること" do
        invalid_params = review_params.deep_dup
        invalid_params[:review][:rate] = 6

        expect do
          post reviews_path, params: invalid_params
        end.not_to change(Review, :count)

        expect(response.status).to eq(200)
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページにリダイレクトすること" do
        post reviews_path, params: review_params

        expect(response).to redirect_to(new_user_session_path)
      end

      it "reviewパラメータがなくても先にログインページへ遷移すること" do
        post reviews_path, params: { field_id: field.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ユーザーがログインしていてreviewパラメータがないとき" do
      before { sign_in user }

      it "ActionController::ParameterMissingになること" do
        expect do
          post reviews_path, params: { field_id: field.id }
        end.to raise_error(ActionController::ParameterMissing)
      end
    end
  end

  describe "DELETE reviews#destroy" do
    let!(:review) { create(:review, user: user, field: field) }

    context "ユーザーがログインしているとき" do
      before { sign_in user }

      it "本人の口コミを削除できること" do
        expect do
          delete review_path(review), headers: { "HTTP_REFERER" => field_path(field) }
        end.to change(Review, :count).by(-1)

        expect(response).to redirect_to(field_path(field))
        expect(flash[:alert]).to eq("口コミを削除しました。")
      end

      it "refererがない場合はキャンプ場詳細にリダイレクトすること" do
        delete review_path(review)

        expect(response).to redirect_to(field_path(field))
      end
    end

    context "別ユーザーがログインしているとき" do
      let(:other_user) { create(:user) }

      before { sign_in other_user }

      it "削除できずキャンプ場詳細にリダイレクトすること" do
        expect do
          delete review_path(review), headers: { "HTTP_REFERER" => field_path(field) }
        end.not_to change(Review, :count)

        expect(response).to redirect_to(field_path(field))
        expect(flash[:alert]).to eq("権限がありません。")
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページにリダイレクトすること" do
        delete review_path(review), headers: { "HTTP_REFERER" => field_path(field) }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "存在しないidを指定したとき" do
      before { sign_in user }

      it "ActiveRecord::RecordNotFoundになること" do
        expect do
          delete review_path(999_999_999), headers: { "HTTP_REFERER" => field_path(field) }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
