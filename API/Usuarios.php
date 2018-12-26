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

    public function crear_respuesta($codigo, $mensaje, $data){
        $respuesta = array('codigo' => $codigo,
                            'mensaje' => $mensaje,
                            'data' => $data);
        return $respuesta;
    }
    public function validar_parametros_get($nombre,$contrasenia){
        if(!empty($nombre) && !empty($contrasenia)){
            return  1;
        }
        else{
            return 0;
        }
    }
    public function validar_parametros_post($nombre, $contrasenia, $id_tipo){
        if(!empty($nombre) && !empty($contrasenia) && !empty($id_tipo)){
        //if($nombre!=NULL && $contrasenia!=NULL && $id_tipo!=NULL){
            return  1;
        }
        else{
            return 0;
        }
    }   
public function ver_tipo_usuario($usuario){
    $id_tipo_usuario=$usuario['id_tipo_usuario'];
    if($id_tipo_usuario == 1){
        return "Administrador";
    }
    elseif($id_tipo_usuario == 2){
        return "Usuario";
    }
    else{
        return 0;
    }
}
public function parametros_definidos_get($nombre, $contrasenia){
    if (isset($nombre, $contrasenia)) {
        return "login";
    }else{
        return "sin parametros";
    }
}
public function mandar_respuesta($respuesta){
    return $this->response($respuesta);
}
/*************************** GET usuarios ********************** */
    public function usuarios_get() {
        /*$respuesta=[
            'codigo' => 404,
            "mensaje" => "No implementado",
            "usuario" =>[]
        ];*/
        //$respuesta=$this->crear_respuesta(REST_Controller::HTTP_NOT_FOUND,"No implementado",[]);
        $nombre=$this->get('nombre');
        $contrasenia=$this->get('contrasenia');
        #Revisamos si estan definidos.
        $opcion=$this->parametros_definidos_get($nombre, $contrasenia);
        switch($opcion){
            #Validamos si no estan vacios
            case "login":
                if($this->validar_parametros_get($nombre,$contrasenia)==1){
                    #(parametros validos) los parametros estan definidos y contienen algo
                    #Hacemos select a la tabla usuario
                    $usuario=$this->Usuarios_model->login($nombre,$contrasenia);
                    #checamos el exito del query
                    if(isset($usuario)){
                        #exito del query
                        if($this->ver_tipo_usuario($usuario) == "Usuario"){
                            #es usuario
                            #veo cuantos playlists tiene
                            $id_playlists=$this->Usuarios_model->id_playlists($usuario['id']);

                            if (isset($id_playlists)) {
                                #exito del query
                           
                                if(Count($id_playlists) > 0){
                                    #Tiene al menos una playlists, le doy formato a la respuesta
                                    $playlists=$this->Usuarios_model->VerPlaylists($usuario['id']);
                                    #checamos el exito del query
                                    if(isset($playlists)){

                                        /*$usuario=[
                                            "id"=>$usuario['id'],
                                            "nombre"=>$usuario['nombre'],
                                            "tipo_usuario"=>"Usuario",
                                            "id_playlists"=>$id_playlists,
                                            "playlists"=>$playlists
                                       ];*/
                                        $usuario['id_playlists'] = $id_playlists;
                                        $usuario['playlists'] = $playlists;
                                        #creo la respuesta
                                        $respuesta=$this->crear_respuesta(200,"usuario y tiene playlist",$usuario);
                                    }else{
                                        #falla query
                                        $respuesta=$this->crear_respuesta(404,"error en la consulta",[]);
                                    }
                                
                                }
                                else{ #No tiene playlists
                                    $respuesta=$this->crear_respuesta(204,"usuario y no tiene playlist",$usuario);
                                   
                                }
                            } 
                            else {
                                #falla query
                                $respuesta=$this->crear_respuesta(404,"error en la consulta",$usuario);
                            }
                        }
                            else { #es Administrador
                                
                                $respuesta=$this->crear_respuesta(200,"Administrador",$usuario);
                               
                            }
                    
                    }
                    else {#falla query
                        $respuesta=$this->crear_respuesta(404,"error en la consulta",[]);
                    }
                }
                else { #falla de los parametros
                        $respuesta=$this->crear_respuesta(400,"error en los parametros",[]);
                }
                break;

            default:
                $usuarios=$this->Usuarios_model->usuarios();
                if (isset($usuarios)) {
                    #exito query
                    $respuesta=$this->crear_respuesta(200,"Usuarios Encontrados", $usuarios);
                } else{
                    #query falla
                    $respuesta=$this->crear_respuesta(404,"error en la consulta", []);
                } 
        }

    $this->mandar_respuesta($respuesta);
               
    }


    public function usuarios_post(){
        $nombre = $this->post('nombre');
        $contrasenia = $this->post('contrasenia');
        $id_tipo = $this->post('id_tipo');

        if (isset($nombre, $contrasenia, $id_tipo)) {
        #parametros definidos    
            if($this->validar_parametros_post($nombre,$contrasenia,$id_tipo)==1){
                #parametros validos
                $existe_nombre = $this->Usuarios_model->existe_nombre($nombre);
                
                if (isset($existe_nombre)){
                    #exito del query
                    if (isset($existe_nombre->id)) {
                        #existe usuario con ese nombre
                        $respuesta = $this->crear_respuesta(200, 'usuario existe', []);
                    } else {
                        #no existe usuario con ese nombre
                        $insert = $this->Usuarios_model->insertar_usuario($nombre, $contrasenia, $id_tipo);
                        #se hace el insert
                        if ($insert == TRUE) {
                            #exito query
                            $respuesta = $this->crear_respuesta(201, 'usuario agregado', []);
                        } else {
                            #exito falla
                            $respuesta = $this->crear_respuesta(202, 'No se pudo agregar el usuario', []);
                        }
                    }
                } else {
                    #query falla
                    $respuesta = $this->crear_respuesta(404, 'Error en la consulta', []);
                }

            } else {
                #parametros no validos
                $respuesta = $this->crear_respuesta(400, 'Error en los parametros', []);
            }

        } else {
            #parametros no definidos
            $respuesta = $this->crear_respuesta(400, 'No implementado', []);
        }
        $this->response($respuesta);
    }

    public function usuarios_delete(){
        $id = $_GET['id'];

        if (isset($id)) {
            if (!empty($id)) {
                $resultado = $this->Usuarios_model->Delete_usuario($id);
                if ($resultado == TRUE) {
                    $respuesta = $this->crear_respuesta(200, 'usuario actualizado', []);
                } else {
                    $respuesta = $this->crear_respuesta(400, 'Error en la consulta', []);
                }
            } else {
                $respuesta = $this->crear_respuesta(400, 'Error en los parametros', []);
            }
        } else {
                $respuesta = $this->crear_respuesta(404, 'No implementado', []);
        }
        $this->response($respuesta);
    }
    public function usuarios_put(){
        $id=$_GET['id'];
        $nombre=$_GET['nombre'];
        $contrasenia= $_GET['contrasenia'];
        $id_tipo_usuario=$_GET['tipo_usuario'];
         #Revisamos si estan definidos
         if(isset($id) && isset($nombre)&& isset($contrasenia)&& isset($id_tipo_usuario) ){
            if($id != NULL){
                    if($nombre == NULL && $contrasenia == NULL && $id_tipo_usuario == NULL){
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "No se moifico nada",
                            "usuario" =>[]
                        ];
                    }
                    elseif ($nombre == NULL && $contrasenia == NULL && $id_tipo_usuario != NULL) {
                        $Usuario_modificado=$this->Usuarios_model->ModificarT($id_tipo_usuario,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre == NULL && $contrasenia != NULL && $id_tipo_usuario == NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarC($contrasenia,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre != NULL && $contrasenia == NULL && $id_tipo_usuario == NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarN($nombre,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre != NULL && $contrasenia != NULL && $id_tipo_usuario == NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarNC($nombre,$contrasenia,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre != NULL && $contrasenia == NULL && $id_tipo_usuario != NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarNT($nombre,$id_tipo_usuario,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre == NULL && $contrasenia != NULL && $id_tipo_usuario != NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarCT($contrasenia,$id_tipo_usuario,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
                    elseif($nombre != NULL && $contrasenia != NULL && $id_tipo_usuario != NULL){
                        $Usuario_modificado=$this->Usuarios_model->ModificarNCT($nombre,$contrasenia,$id_tipo_usuario,$id);
                        $respuesta=[
                            'codigo' => REST_Controller::HTTP_OK,
                            "mensaje" => "usuario Modificado ",
                            "usuario" =>$Usuario_modificado
                        ];
                    }
            }
            else{
                $respuesta=[
                    'codigo' => REST_Controller::HTTP_BAD_REQUEST,
                    "mensaje" => "Algo salio mal, no se moifico nada",
                    "usuario" =>[]
                ];
            }
        }
        else{
            $usuario=$this->Usuarios_model->Usuarios($nombre,$contrasenia);
            $respuesta=[
                'codigo' => REST_Controller::HTTP_NOT_FOUND,
                "mensaje" => "NO IMPLEMENTADO",
                "usuario" =>[]
            ];
                
        }
        $this->set_response($respuesta);
    }       

}
