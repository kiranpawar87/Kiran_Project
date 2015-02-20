class Users::SessionsController < Devise::SessionsController
  def new
    @posts="Sessions controller new"
    super
  end
  def create
    @posts="Sessions controller create"
    super
  end
  def destroy
    @posts="Sessions controller destroy"
    super
  end
end
