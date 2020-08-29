require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
  
  it "nickname,email,password,password_confirmation,last_name,first_name,last_name_k,first_name_k,birth_dateが存在すれば登録できること" do
    expect(@user).to be_valid
  end

  it "nicknameが空では登録できないこと" do
    @user.nickname = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Nickname can't be blank")
  end

  it "emailが空では登録できないこと" do
    @user.email = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it "重複したemailが存在する場合登録できないこと" do
    @user.save
    another_user = FactoryBot.build(:user)
    another_user.email = @user.email
    another_user.valid?
    expect(another_user.errors.full_messages).to include("Email has already been taken")
  end

  it "emailに@が含まれていないと登録できない" do
    @user.email = "sample12345.ab"
    @user.valid?
    expect(@user.errors.full_messages).to include("Email is invalid")
  end

  it "passwordが空では登録できないこと" do
    @user.password = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end

  it "passwordが6文字以上であれば登録できること" do
    @user.password = "111aaa"
    @user.password_confirmation = @user.password
    expect(@user).to be_valid
  end

  it "passwordが5文字以下では登録できないこと" do
    @user.password = "111aa"
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end

  it "passwordは半角英数混合でないと登録できないこと(数字のみ)" do
    @user.password = "111111"
    @user.password_confirmation = @user.password
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is invalid")
  end

  it "passwordは半角英数混合でないと登録できないこと(英字のみ)" do
    @user.password = "aaaaaa"
    @user.password_confirmation = @user.password
    @user.valid?
    expect(@user.errors.full_messages).to include("Password is invalid")
  end

  it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
    @user.password_confirmation = ""
    @user.valid?
    expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "last_nameが空では登録できないこと" do
    @user.last_name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name can't be blank")
  end

  it "last_nameはひらがな、カタカナ、漢字しか入力できないこと" do
    @user.last_name = "tom"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name is invalid")
  end

  it "first_nameが空では登録できないこと" do
    @user.first_name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("First name can't be blank")
  end

  it "first_nameはひらがな、カタカナ、漢字しか入力できないこと" do
    @user.first_name = "123"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name is invalid")
  end

  it "last_name_kが空では登録できないこと" do
    @user.last_name_k = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name k can't be blank")
  end

  it "last_name_kはカタカナしか入力できないこと" do
    @user.last_name_k = "とむ"
    @user.valid?
    expect(@user.errors.full_messages).to include("Last name k is invalid")
  end

  it "first_name_kが空では登録できないこと" do
    @user.first_name_k = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("First name k can't be blank")
  end

  it "first_name_kはカタカナしか入力できないこと" do
    @user.first_name_k = "広島"
    @user.valid?
    expect(@user.errors.full_messages).to include("First name k is invalid")
  end

  it "birth_dateが空では登録できないこと" do
    @user.birth_date = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Birth date can't be blank")
  end

  end
end
