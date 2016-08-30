class SettingsController < ApplicationController

  def index
    @settings = Setting.all
  end

  def update
    @setting = Setting.find(params[:id])
    respond_to do |format|
      if @setting.update(setting_params)
        format.js
      else
        format.js
      end
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:value)
  end
end
