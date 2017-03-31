class UsuariosController < ApplicationController
  before_action :set_usuario, only: [:edit]

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.all
    # respond_to do |format|
    #   format.html
    #   format.json { render :json => @usuarios }
    # end
  end

  def show_all
    @usuarios = Usuario.all
    hash = {'usuarios' => @usuarios, 'total' => @usuarios.count}.to_json
    # @usuarios.each do |p|
    respond_to do |format|
      # format.html
      format.json { render :json => hash }
      #format.json { render :json => @usuarios.select(:id, :nombre, :apellido, :usuario, :twitter)}
      # format.json { render json: {"id": p.id, "nombre": p.nombre, "apellido": p.apellido, "usuario": p.usuario, "twitter": p.twitter}.to_json, :status => 200}
    end
    # end
  end
  # def editar_usuario
  #   @usuario = Usuario.find_by_id(params[:id])
  #   if @usuario.nil?
  #     render :json => {:error => "Usuario no encontrado en edit usuario"}.to_json, :status => 404
  #     render :json => {:error => "La modificación ha fallado"}.to_json, :status => 500
  #     render :json => {:error => "id no es modificable"}.to_json, :status => 400
  #   else
  #     respond_to do |format|
  #         #format.json { render json: {"id": @usuario.id, "nombre": @usuario.nombre, "apellido": @usuario.apellido, "usuario": @usuario.usuario, "twitter": @usuario.twitter}.to_json, :status => 200}
  #         format.json { render json: {"id": @usuario.id, "nombre": @usuario.nombre, "apellido": @usuario.apellido, "usuario": @usuario.usuario, "twitter": @usuario.twitter}.to_json, :status => 200}
  #         format.html { render :show}
  #     end
  #   end
  # end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find_by_id(params[:id])
    if @usuario.nil?
      render :json => {:error => "Usuario no encontrado"}.to_json, :status => 404
    else
      respond_to do |format|
          format.json { render json: {"id": @usuario.id, "nombre": @usuario.nombre, "apellido": @usuario.apellido, "usuario": @usuario.usuario, "twitter": @usuario.twitter}.to_json, :status => 200}
          format.html { render :show}
      end
    end
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
  end

  def create_new
    if (params[:id])
      respond_to do |format|
        format.json { render :json => {:error => "No se puede crear usuario con id"}.to_json, :status => 400 }
      end
    else
      @usuario = Usuario.new({"nombre":params[:nombre], "apellido":params[:apellido], "usuario":params[:usuario], "twitter":params[:twitter]})
      respond_to do |format|
      # format.json { render json: {"nombre":params[:nombre], "apellido":params[:apellido], "usuario":params[:usuario], "twitter":params[:twitter]}}
        if @usuario.save
          #format.html { redirect_to @usuario, notice: 'Usuario was successfully created.' }
          format.json { render json: {"id": @usuario.id, "nombre": @usuario.nombre, "apellido": @usuario.apellido, "usuario": @usuario.usuario, "twitter": @usuario.twitter}, status: :created }
        else
          #format.html { render :new }
          format.json { render :json => {:error => "La creación ha fallado aca"}.to_json, :status => 500 }
        end
      end
    end
  end
  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
    respond_to do |format|
      if @usuario.save
        format.html { redirect_to @usuario, notice: 'Usuario was successfully created.' }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /usuarios/1
  # PATCH/PUT /usuarios/1.json
  def update
    @usuario = Usuario.find_by_id(params[:id])
    if @usuario.nil?
      render :json => {:error => "Usuario no encontrado"}.to_json, :status => 404

      #render :json => {:error => "id no es modificable"}.to_json, :status => 400
    else
      if usuario_params.count==1
        respond_to do |format|
          # format.json { render json: usuario_params.count}
          if @usuario.update(usuario_params)
            #format.json { render json: @usuario}

            #format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
            #el segundo
            format.json { render :show, status: :ok, location: @usuario }
          end
        end
      elsif usuario_params.count==0
        # JSON.parse(usuario_params)
        respond_to do |format|
          format.json { render :json => {:error => "id no es modificable"}.to_json, :status => 400 }
        end
      else
        respond_to do |format|
          format.json { render :json => {:error => "La modificación ha fallado"}.to_json, :status => 500 }
        end
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find_by_id(params[:id])
    if @usuario.nil?
      render :json => {:error => "Usuario no encontrado"}.to_json, :status => 404
    else
      @usuario.destroy
      respond_to do |format|
        #format.html { redirect_to usuarios_url, notice: 'Usuario was successfully destroyed.' }
        format.json { render :json => {}.to_json, :status => 204 }
        # format.json { head :no_content, status => 204}
      end
    end
  end

  private
    def record_not_found(error)
      render :json => {:error => "Usuario no encontrado 2"}.to_json, :status => 404
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def usuario_params
      params.require(:usuario).permit(:nombre, :apellido, :usuario, :twitter)
    end
end
