require 'rails_helper'

describe 'PostAPI' do
  it '全てのポストを取得する' do
    FactoryBot.create_list(:post, 10)

    get '/api/v1/posts'
    json = JSON.parse(response.body)

    # リクエスト成功を表す200が返ってきたか確認する。
    expect(response.status).to eq(200)

    # 正しい数のデータが返されたか確認する。
    expect(json['data'].length).to eq(10)
  end

  it '特定のpostを取得する' do
    post = create(:post, content: 'test-content')

    get "/api/v1/posts/#{post.id}"
    json = JSON.parse(response.body)

    expect(response.status).to eq(200)

    expect(json['data']['content']).to eq(post.content)
  end

  


end