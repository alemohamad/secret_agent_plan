class AgentsController < ApplicationController
  before_filter :set_agent, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:filter].present?
      if params[:filter][:on_assignment]
        @agents = Agent.on_assignment
      else
        @agents = Agent.not_on_assignment
      end
    else
      @agents = Agent.all
    end
  end
  
  def show
  end
  
  def new
    @agent = Agent.new
  end
  
  def create
    @agent = Agent.new(agent_params)
    
    if @agent.save
      redirect_to agents_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @agent.update(agent_params)
      redirect_to @agent
    else
      render :edit
    end
  end
  
  def destroy
    @agent.destroy
    redirect_to agents_path
  end
  
  private
  
  def set_agent
    @agent = Agent.find(params[:id])
  end
  
  def agent_params
    params.require(:agent).permit(:first_name, :last_name, :email)
  end
end
