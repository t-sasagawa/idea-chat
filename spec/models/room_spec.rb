require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#create' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'nameの値が存在すれば登録できること' do
      expect(@room).to be_valid
      # ここにuser_idも紐付いた状態で登録できることを証明したい
      # 紐づく情報は載せなくてもよいのか？？
    end

    it 'nameが空では登録できないこと' do
      @room.name = ''
      @room.valid?
      expect(@room.errors.full_messages).to include("Name can't be blank")
    end
  end
end