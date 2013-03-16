class PunchesController < ApplicationController
  before_filter :authenticate
  before_filter :load_punches, only: [:index]

  def index
    @punch = Punch.new
  end

  def create
    @punch = Punch.new params[:punch]
    @punch.origin_ip = request.ip

    if @punch.save
      flash[:notice] = 'Punched!'
      redirect_to root_path
    else
      flash.now[:error] = @punch.errors.full_messages.join(', ')

      load_punches
      render :index
    end
  end

  def destroy
    @punch = Punch.find params[:id]
    @punch.destroy

    flash[:notice] = 'Punch deleted!'
    redirect_to root_path
  end

  private

  def load_punches
    @punches = Punch.ordered
  end
end
