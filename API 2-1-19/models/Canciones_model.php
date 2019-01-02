<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class Canciones_model extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
    }
private function validar_select($query){
        if($query->conn_id->sqlstate == "00000"){
            #el query tuvo exito
            return 1;
        }
        else{
            #el query fallo
            return 0;
        }
    }
private function validar_select_post($query){
        if($query->conn_id->sqlstate == "00000"){
            #el query tuvo exito
            $existe=$query->result_array();
            //if(!is_null($existe[0]['id'])){
            if(count($existe) > 0){
            #existe
                return 1;
            }
            else{
                #no existe
                return 2;
            }
        }
        else{
            #el query fallo
            return 0;
        }
        
    }
private function validar_insert($query){
    	if ($query == TRUE) {
    		return 1;
    	}else{
    		return 0;
    	}
    }
public function ver_canciones(){
    #se hace la consulta para saber las canciones junto con el nombre de sus respectivos album y artista
    $canciones = $this->db->query('SELECT canciones.id, canciones.nombre as "cancion" ,
                                    albums.nombre as "album", artistas.nombre as "artista", 
                                    canciones.direccion as "direccion"
                                    FROM canciones INNER JOIN artistas ON artistas.id = canciones.id_artista 
                                                 INNER JOIN albums ON albums.id =canciones.id_album');
   #checamos si el selecl tuvo exito
   if($this->validar_select($canciones)==1){
        #exito, mandamos las canciones como arreglo
        return $canciones->result_array();
    }
    else{
        #fallo, mandamos nulo

        return 0;
    }
    
}
public function artista_existe($artista){
    $artista_existe=$this->db->query('SELECT id FROM artistas WHERE nombre = "'.$artista.'"');
    #checamos el exito y si qiene algo
    if($this->validar_select_post($artista_existe)>0){
        #exito del query
        if($this->validar_select_post($artista_existe)==1){
                #existe el artista
                return 1;
        }else{
            #no existe el artista
                return 2;
        }
    }else{
        #falla query
        return 0;
    }
}
public function album_existe($album){
    $album_existe=$this->db->query('SELECT id FROM albums WHERE nombre = "'.$album.'"');
    #checamos el exito y si qiene algo
    if($this->validar_select_post($album_existe)>0){
        #exito del query
        if($this->validar_select_post($album_existe)==1){
                #existe el album
                return 1;
        }else{
            #no existe el album
                return 2;
        }
    }else{
        #falla query
        return 0;
    }
}
public function cancion_existe($nombre){
    $cancion_existe=$this->db->query('SELECT id FROM canciones WHERE nombre = "'.$nombre.'"');
    #checamos el exito y si qiene algo
    if($this->validar_select_post($cancion_existe)>0){
        #exito del query
        if($this->validar_select_post($cancion_existe)==1){
                #existe la cancion
                return 1;
        }else{
            #no existe el cancion
                return 2;
        }
    }else{
        #falla query
        return 0;
    }
}
public function artista_nuevo($artista){
    $artista_nuevo=$this->db->query('INSERT INTO artistas (nombre) VALUES("'.$artista.'")');
    #checamos el exito del insert
    if($this->validar_insert($artista_nuevo)==1){
        #Artista agregado
        return 1;
    }
    else{
        #No se agrego el artista
        return 0;
    }
    
}
public function album_nuevo($artista,$album){
    $album_nuevo=$this->db->query('INSERT INTO albums (nombre, id_artista) 
                                    VALUES ( "'.$album.'",
                                    (SELECT id FROM artistas WHERE nombre = "'.$artista.'"))');
    #checamos el exito del insert
    if($this->validar_insert($album_nuevo)==1){
        #Artista agregado
        return 1;
    }
    else{
        #No se agrego el artista
        return 0;
    }
    
}
public function cancion_nueva($nombre,$artista,$album,$id_genero,$direccion){
    $cancion_nueva=$this->db->query('INSERT INTO canciones (nombre,id_album,id_artista,id_genero,direccion)
                                    VALUES("'.$nombre.'",
                                    (SELECT id FROM albums WHERE nombre = "'.$album.'"),
                                    (SELECT id FROM artistas WHERE nombre = "'.$artista.'"),
                                    '.$id_genero.', "'.$direccion.'" )');
    #checamos el exito del insert
    if($this->validar_insert($cancion_nueva)==1){
        #Artista agregado
        return 1;
    }
    else{
        #No se agrego el artista
        return 0;
    }
    
}
}