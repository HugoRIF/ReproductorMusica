<?php
use Restserver\Libraries\REST_Controller;
defined('BASEPATH') OR exit('No direct script access allowed');

require APPPATH . 'libraries/REST_Controller.php';
require APPPATH . 'libraries/Format.php';

class Usuarios extends REST_Controller {

    function __construct()
    {
        parent::__construct();

        $this->load->database();
        $this->load->model('Usuarios_model');
        $this->load->helper('url');

    }

    private function crear_respuesta($codigo, $mensaje, $data){
        $respuesta = array('codigo' => $codigo,
                            'mensaje' => $mensaje,
                            'data' => $data);
        return $respuesta;
    }
    

/*************************** GET usuarios ********************** */

    private function validar_parametros_get($nombre,$contrasenia){
        if(!empty($nombre) && !empty($contrasenia)){
            return  1;
            #es 1 cuando nombre y contrasenia no son vacios
        }
        else{
            return 0;
            #es 0 cuando alguno o ambos son vacios
        }
    }   
    private function ver_tipo_usuario($usuario){
        $id_tipo=$usuario['id_tipo'];
        if($id_tipo == 2){
            return 2;
            #es 2 cuando es tipo usuario
        }
        else{
            return 1;
            #es 1 cuando es tipo administrador
        }
    }
    private function checar_parametros_definidos_get($nombre, $contrasenia){
        if (isset($nombre, $contrasenia)) {
            return 1;
            #es 1 cuando nombre y contrasenia estan definidos
        }elseif(is_null($nombre) && is_null($contrasenia)){
            return 2;
            #es 2 cuando nombre y contrasenia no estan definidos
        }else{
            return 0;
            #es 0 cuando solo uno esta definido
        }
    }

    public function usuarios_get() {
        $nombre=$this->get('nombre');
        $contrasenia=$this->get('contrasenia');
        #Revisamos si estan definidos.
        $opcion=$this->checar_parametros_definidos_get($nombre, $contrasenia);
        switch($opcion){
            #Validamos si no estan vacios
            case 1:
                if($this->validar_parametros_get($nombre,$contrasenia)==1){
                    #(parametros validos) los parametros estan definidos y contienen algo
                    #Hacemos select a la tabla usuario
                    $usuario=$this->Usuarios_model->login($nombre,$contrasenia);
                    #checamos el exito del query
                    if($usuario != 0){
                        #exito del query
                        if($this->ver_tipo_usuario($usuario) == 2){
                            #es usuario
                            #veo cuantos playlists tiene
                            $id_playlists=$this->Usuarios_model->id_playlists($usuario['id']);

                            if ($id_playlists != 0) {
                                #exito del query
                           
                                if(count($id_playlists) > 0){
                                    #Tiene al menos una playlists
                                    $playlists=$this->Usuarios_model->ver_playlists($usuario['id']);
                                    #checamos el exito del query
                                    if($playlists != 0){

                                        /*$usuario=[
                                            "id"=>$usuario['id'],
                                            "nombre"=>$usuario['nombre'],
                                            "tipo_usuario"=>"Usuario",
                                            "id_playlists"=>$id_playlists,
                                            "playlists"=>$playlists
                                       ];*/
                                        //$usuario['id_playlists'] = $id_playlists;
                                        $usuario['playlists'] = $playlists;
                                        #creo la respuesta
                                        $respuesta=$this->crear_respuesta(200,"tipo usuario y tiene playlist",$usuario);
                                    }else{
                                        #falla query
                                        $respuesta=$this->crear_respuesta(404,"error en la consulta de las canciones",[]);
                                    }
                                
                                }
                                else{ #No tiene playlists
                                    $respuesta=$this->crear_respuesta(200,"tipo usuario y no tiene playlist",$usuario);
                                   
                                }
                            } 
                            else {
                                #falla query
                                $respuesta=$this->crear_respuesta(404,"error en la consulta de las playlists",$usuario);
                            }
                        }
                            else { #es Administrador
                                $respuesta=$this->crear_respuesta(200,"tipo administrador",$usuario);
                            }
                    }
                    else {#falla query
                        $respuesta=$this->crear_respuesta(404,"error en la consulta del usuario",[]);
                    }
                }
                else { #falla de los parametros
                        $respuesta=$this->crear_respuesta(400,"error en los parametros",[]);
                }
                break;

            case 2:
                $usuarios=$this->Usuarios_model->usuarios();
                //$usuarios=$this->Usuarios_model->ver_playlists("3");
                if (!is_null($usuarios)) {
                    #exito query
                    $respuesta=$this->crear_respuesta(200,"Usuarios Encontrados", $usuarios);
                } else{
                    #query falla
                    $respuesta=$this->crear_respuesta(404,"error en la consulta de los usuarios", []);
                }
                break;

            default:
                 $respuesta=$this->crear_respuesta(200, "No implementado", []); 
        }

    $this->response($respuesta);
               
    }

    /* ******************** POST ********************** */

    private function checar_parametros_definidos_post($nombre, $contrasenia, $id_tipo){
        if (isset($nombre, $contrasenia, $id_tipo)) {
            return 1;
            #es 1 cuando los parametros estan definidos
        }else{
            return 0;
            #es 0 cuando no estan definidos
        }
    }
    private function validar_parametros_post($nombre, $contrasenia, $id_tipo){
        if(!empty($nombre) && !empty($contrasenia) && !empty($id_tipo) && $id_tipo>0){
            return  1;
            #es 1 cuando no son vacios y el id es >0
        }
        else{
            return 0;
            #es 0 cuando son vacios o el id no es >0
        }
    }

    public function usuarios_post(){
        $nombre = $this->post('nombre');
        $contrasenia = $this->post('contrasenia');
        $id_tipo = $this->post('id_tipo');
        $opcion = $this->checar_parametros_definidos_post($nombre, $contrasenia, $id_tipo);

        switch ($opcion){
            case 1:
            #parametros definidos    
                if($this->validar_parametros_post($nombre,$contrasenia,$id_tipo)==1){
                    #parametros validos
                    $existe_nombre = $this->Usuarios_model->existe_nombre($nombre);
                    
                    if ($existe_nombre != 0){
                        #exito del query
                        if ($existe_nombre == 1){
                            #existe usuario con ese nombre
                            $respuesta = $this->crear_respuesta(200, 'nombre de usuario ya existe', []);
                        } else {
                            #no existe usuario con ese nombre
                            $insert = $this->Usuarios_model->insertar_usuario($nombre, $contrasenia, $id_tipo);
                            #se hace el insert
                            if ($insert == 1) {
                                #exito query
                                $respuesta = $this->crear_respuesta(201, 'usuario agregado', []);
                            } else {
                                #exito falla
                                $respuesta = $this->crear_respuesta(202, 'no se pudo agregar el usuario', []);
                            }
                        }
                    } else {
                        #query falla
                        $respuesta = $this->crear_respuesta(404, 'error en la consulta', []);
                    }

                } else {
                    #parametros no validos
                    $respuesta = $this->crear_respuesta(400, 'error en los parametros', []);
                }
                break;

            default:
                #parametros no definidos
                //$existe_nombre = $this->Usuarios_model->existe_nombre('David');
                $respuesta = $this->crear_respuesta(400, 'no implementado', []);
        }

        $this->response($respuesta);
    }

    /* ******************** DELETE ********************** */

    private function checar_parametros_definidos_delete($id){
        if (isset($id)) {
            return 1;
            #es 1 cuando el id esta definido
        }else{
            return 0;
            #es 0 cuando no esta definido
        }
    }
    private function validar_parametros_delete($id){
        if(!empty($id) && $id>0){
            return  1;
            #es 1 cuando no es vacio y es >0
        }
        else{
            return 0;
            #es 0 cuando es vacio o no es >0
        }
    }

    public function usuarios_delete(){
        $id = $_GET['id'];
        $opcion=$this->checar_parametros_definidos_delete($id);
        #se valida que el id este definido
        switch ($opcion) {
            case 1:
            #id definido
                if($this->validar_parametros_delete($id)==1){
                    #se valida que el id sea >0
                    $delete_usuario = $this->Usuarios_model->delete_usuario($id);
                    #se realiza el delete (update) que es borrado logico
                    if ($delete_usuario == 1) {
                        #query exitoso, se afecto un usuario
                        $respuesta = $this->crear_respuesta(200, 'usuario actualizado', []);
                    } else {
                        #no se afecto a ningun usuario
                        $respuesta = $this->crear_respuesta(400, 'error en la consulta, no se elimino o ya esta eliminado', []);
                    }
                }else{
                    #el id no es valido
                    $respuesta = $this->crear_respuesta(400, 'error en los parametros', []);
                }
                break;
            
            default:
                //$prueba = $this->Usuarios_model->delete_usuario(21);
                #el id no esta definido
                $respuesta = $this->crear_respuesta(404, 'no implementado', []);
                break;
        }
        $this->response($respuesta);
    }

    /* ******************** PUT ********************** */

    private function checar_parametros_definidos_put($id,$nombre,$contrasenia,$id_tipo){
        if(isset($id, $nombre, $contrasenia, $id_tipo) && $id>0){
            #todos estan bien
            return 1;
        }
        else{
            return 0;
        }
    }    
    private function validar_parametros_put($id,$nombre,$contrasenia,$id_tipo){
        
        if($id >0 ){
            #el id  valido
            if(!empty($nombre) && !empty($contrasenia) && !empty($id_tipo) && $id_tipo>0){
                #se va a modificar todo
                return 1;
            }
            else{
                if(!empty($nombre) && empty($contrasenia) && empty($id_tipo)){
                    #solo modificar nombre
                    return 2;   
                }
                elseif (empty($nombre) && !empty($contrasenia)  && empty($id_tipo)) {
                    # solo modifico contraseña
                    return 3; 
                }
                elseif(empty($nombre) && empty($contrasenia) && !empty($id_tipo) && $id_tipo>0){
                    #modifico el tipo de usuario 
                    return 4;
                }
                elseif(!empty($nombre) && !empty($contrasenia) && empty($id_tipo)){
                    #modifico nombre y contraseña
                    return 5;
                }
                elseif(!empty($nombre) && empty($contrasenia) && !empty($id_tipo) && $id_tipo>0){
                    #modifico nombre y tipo de usuario 
                    return 6;
                }
                elseif(empty($nombre) && !empty($contrasenia) && !empty($id_tipo) && $id_tipo>0){
                    #modifico contrasenia y tipo de usuario
                    return 7;
                }
            }
        }
        else{
           #el id invalido
           #no se hara mada, error en los parametros
           return 0;
        }

    }
    public function usuarios_put(){
            $id=$this->put('id');
            $nombre=$this->put('nombre');
            $contrasenia=$this->put('contrasenia');
            $id_tipo=$this->put('id_tipo');
            $opcion = $this->checar_parametros_definidos_put($id,$nombre,$contrasenia,$id_tipo);
            switch ($opcion) {
                case 1:
                    #parametros definidos
                    $parametros_a_modificar=$this->validar_parametros_put($id,$nombre,$contrasenia,$id_tipo);
                    switch ($parametros_a_modificar) {
                        case 1:#se modifica todo
                            $modificar_usuario=$this->Usuarios_model->modificar_todo($id,$nombre,$contrasenia,$id_tipo);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                        case 2:# se modifica solo el nombre
                            $modificar_usuario=$this->Usuarios_model->modificar_nombre($id,$nombre);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado solo nombre",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                         case 3: #se modifica solo la contraseña
                            $modificar_usuario=$this->Usuarios_model->modificar_contrasenia($id,$contrasenia);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado solo contrasenia",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                         case 4:# se modifica el tipo usuario
                            $modificar_usuario=$this->Usuarios_model->modificar_tipo_usuario($id,$id_tipo);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado solo tipo",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                         case 5:# se modifica el nombre y la contraseña
                            $modificar_usuario=$this->Usuarios_model->modificar_nombre_contrasenia($id,$nombre,$contrasenia);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado nombre y contrasenia",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                         case 6:# se modifica en nombre y el tipo usuario
                            $modificar_usuario=$this->Usuarios_model->modificar_nombre_tipo($id,$nombre,$id_tipo);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado nombre y tipo",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                         case 7: # se modifica la contraseña y el tipo usuario
                            $modificar_usuario=$this->Usuarios_model->modificar_contasenia_tipo($id,$contrasenia,$id_tipo);
                            #checo si se modifico
                            if($modificar_usuario==1){
                                $respuesta=$this->crear_respuesta(200,"usuario actualizado contrasenia y tipo",[]);
                            }
                            else{
                                $respuesta=$this->crear_respuesta(400,"no se pudo actualizar",[]);
                            }
                            break;
                        default:
                            $respuesta=$this->crear_respuesta(200,"no se modifico nada",[]);
                            break;
                    }
                    break;
                /*case 0:
                    $respuesta=$this->crear_respuesta(400,"error en los parametros",[]);
                    break;*/
                
                default:
                    #parametros no definidos
                    $respuesta=$this->crear_respuesta(400,"no implementado",[]);
                    break;
            }
            $this->response($respuesta);
    }
}
