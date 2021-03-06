require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemailとpasswordとpassword_confirmationとfamily_nameとfirst_nameとkana_family_nameとkana_first_nameとbirthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空だと登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "emailが重複していると登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "emailに＠が含まれていないと登録できない" do
        @user.email ="yonedaicloud.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "passwordが空だと登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "passwordが5文字以下だと登録できない" do
        @user.password = "000kk"
        @user.password_confirmation = "000kk"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが半角英数だけでは登録できない" do
        @user.password = "dddddd"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password confirmation doesn't match Password", "Password is invalid")
      end
      it "passwordが半角数字だけでは登録できない" do
        @user.password = "333333"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password", "Password confirmation doesn't match Password", "Password is invalid")
      end
      it "family_nameが空だと登録できない" do
        @user.family_name =''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid")
      end
      it "family_nameが全角でないと登録できない" do
        @user.family_name = "test"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end
      it "first_nameが空だと登録できない" do
        @user.first_name =''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end
      it "first_nameが全角でないと登録できない" do
        @user.first_name ="test"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it "kana_family_nameが空だと登録できない" do
        @user.kana_family_name =''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name can't be blank", "Kana family name is invalid")
      end
      it "kana_family_nameが全角カナでないと登録できない" do
        @user.kana_family_name = "山田"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana family name is invalid")
      end
      it "kana_first_nameが空だと登録できない" do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to  include("Kana first name can't be blank", "Kana first name is invalid")
      end
      it "kana_first_nameが全角カナでないと登録できない" do
        @user.kana_first_name =  "太朗"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first name is invalid")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday =''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
    
  end
end
