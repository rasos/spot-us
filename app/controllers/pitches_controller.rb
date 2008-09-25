class PitchesController < ApplicationController
  before_filter :block_if_donated_to, :only => :edit
  before_filter :store_location, :only => :show
  resources_controller_for :pitch

  def block_if_donated_to
    pitch = find_resource(params[:id])
    if pitch.donated_to?
      access_denied(:flash => "You cannot edit a pitch that has donations.", 
                    :redirect => pitch_url(pitch)) 
    end
  end
  
  protected
  
  def new_resource
    current_user.pitches.new((params[:pitch] || {}).merge(:headline => params[:headline]))
  end
  
end
