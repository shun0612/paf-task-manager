class UsersController < ApplicationController
   before_action :authenticate_user, {only: [:show, :edit, :update]}
   before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
   before_action :ensure_correct_user, {only: [:show, :edit, :update]}

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      $sort = "deadline"
      $search = "uncomplete"
      redirect_to("/tasks/#{@user.id}/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def twitter
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    flash[:notice] = "ログインしました"
    $sort = "deadline"
    $search = "uncomplete"
    redirect_to("/tasks/#{@user.id}/index")
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/tasks/#{@user.id}/index")
    else
      render("users/new")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(users_params)
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def new
    @user = User.new
  end

  def users_params
    params.require(:user).permit(:name,:email,:password)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/tasks/#{@current_user.id}/index")
    end
  end

end
