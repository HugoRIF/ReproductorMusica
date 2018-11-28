<section class="container py-3 mt-2 mb-2">
     <div class="row mt-2 mb-2 text-white">
        <div class=" col-12 col-sm-12 col-md-12 col-lg-12">
            <h1 class="h1 text-center d-none d-sm-block ">REGISTRAR USUARIO:</h1>
            <h2 class="h2 text-left d-block d-sm-none">REGISTRAR USUARIO:</h2>
            
                  
        </div>
        <br>  <br>  <br>  <br>  
        <div class="col-12 col-sm-12 col-md-12 ">
                    <section class="container">
                            <form action="<?= base_url() ?>index.php/Administrador/Agregar_Usuario_Nuevo" method="post">
                                <div class="form-group row">
                                    <label for="" class="col-4  col-form-label d-none d-sm-block"><h3>Usuario:</h3></label>    
                                    <input type="text" placeholder="Escribe tu usuario aquí:" class="form-control col-8 col-sm-8 col-md-4" name="usuario">
                                    
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block"><h3>Contraseña:</h3></label>
                                    <input type="password" placeholder="Escribe tu contraseña:" class="form-control col-8 col-sm-8 col-md-4" name="contra">
                        
                                </div>
                                <div class="form-group row">
                                    <label for="" class="col-4 col-form-label d-none d-sm-block"><h3>Tipo Usuario:</h3></label>
                                    <select name="Tipo" class=" color1 dropdown text-white" >
                                        <option  class=" color1  text-white">Administrador</option>
                                        <option class=" color1 text-white">Usuario</option>
                                        
                                    </select>
                                </div>
                                <br>
                                    <center>
                                    <div class="form-group col-6 col-sm-6 col-md-6 col-lg-6 ">
                                        <input type="submit"  class="btn-lg color1 text-white border-white" value="Registrar">
                        
                                    </div>
                                </div>
                                </center>
                           </form>
                           
                                    <div class=" col-12">
                                    <center>
                                        <button class="btn-lg btn-warning  border-white" onclick="Usuarios()">Cancelar</button>
                                    </center>
                                    </div>
                                    
                    </section>
                                   
        </div>

    
</section>
<br><br><br><br>
