class MaintenancesController < ApplicationController
  before_action :set_grave, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  before_action :require_user
  before_action :set_header_menu_active
  # GET /maintenances
  # GET /maintenances.json
  def index
    @o_all = get_records(params[:maintenance], params[:page])
    @params_arr = ['interred_name']
    @o_single = controller_name.classify.constantize.new
    session[:search_params] = params[:maintenance] ? params[:maintenance] : nil
  end

  def show_grave_search
    @o_single = Maintenance.new
  end

  # GET /maintenances/1
  # GET /maintenances/1.json
  def show
  end

  # GET /maintenances/new
  def new
    @o_single = Maintenance.new
  end

  # GET /maintenances/1/edit
  def edit
  end

  # POST /maintenances
  # POST /maintenances.json
  def create
    @o_single = Maintenance.new(grave_params)

    respond_to do |format|
      if @o_single.save
        format.html { redirect_to maintenances_url, notice: t("general.successfully_created") }
        format.json { render action: 'show', status: :created, location: @o_single }
      else
        format.html { render action: 'new' }
        format.json { render json: @o_single.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maintenances/1
  # PATCH/PUT /maintenances/1.json
  def update
    respond_to do |format|
      if @o_single.update(grave_params)
        format.html { redirect_to maintenances_url, notice: t("general.successfully_updated") }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @o_single.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /maintenances/1
  # DELETE /maintenances/1.json
  def destroy
    @o_single.destroy
    respond_to do |format|
      format.html { redirect_to maintenances_url, notice: t("general.successfully_destroyed") }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_grave
      @o_single = Maintenance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grave_params
      params.require(:maintenance).permit!
    end
    
    #fetch search records
    def get_records(search, page)
      grave_query = @cemetery.maintenances.search(search)
      grave_query.order(sort_column + " " + sort_direction).paginate(:per_page => 10, :page => page)
    end    
    
    #set header menu active
    def set_header_menu_active
      @maintenance_active = "active"
    end
    
    #column sort
    def sort_column
      Maintenance.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
  
    #column sort
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end  
end
