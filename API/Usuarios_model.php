<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class Usuarios_model extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}

	/*function Usuarios(){
		//$query = "SELECT * FROM usuario";
  		$query = "SELECT id, nombre, id_tipo_usuario FROM usuario";
  		return ($this->db->query($query)->result());
	}*/

	public function usuarios(){
    	$usuarios=$this->db->query('SELECT id,nombre,id_tipo_usuario
                                FROM usuario' )->result();
    	
    	if($this->validar_select($usuarios)==1){
            return $usuarios;
        }
        else{
            return NULL;
	   }
   
    
    return  $result;
   
    }
    public function validar_select($query){
        if(isset($query)){
            return 1;
        }
        else{
            return 0;
        }
    }
    public function validar_insert($query){
    	if ($query == TRUE) {
    		return TRUE;
    	}else{
    		return FALSE;
    	}
    }
	public function login($nombre,$contrasenia){
	    $query_usuario=$this->db->query('SELECT id,nombre,id_tipo_usuario 
                                  FROM usuario 
                                  WHERE nombre="'.$nombre.'"
                                  AND contrasenia="'.$contrasenia.'"' )->result()[0];
        
        if($this->validar_select($query_usuario)==1){
            $usuario=[
                'id' => $query_usuario->id,
                'nombre' => $query_usuario->nombre,
                'id_tipo_usuario' => $query_usuario->id_tipo_usuario,
                
            ];
            return $usuario;
        }
        else{
            return NULL;
	   }
	    
	}
	public function prueba(){
	    $r="no sirve";
	    return $r;
	}
	public function verPlaylists($id){
	    $playlists=$this->db->query('SELECT playlist.id as "id_playlist", playlist.nombre as "nombre_playlist", cancion.id AS "id_cancion", cancion.nombre AS "nombre_cancion", artista.nombre AS "artista_cancion", album.nombre AS "album_cancion", cancion.direccion AS "direccion_cancion" FROM playlist JOIN playlist_con_canciones ON playlist.id = playlist_con_canciones.id_playlist JOIN cancion ON cancion.id = playlist_con_canciones.id_cancion JOIN artista ON cancion.id_artista = artista.id JOIN album ON cancion.id_album = album.id WHERE playlist.id_usuario ='.$id )->result();

	    if($this->validar_select($playlists)==1){
            return $playlists;
        }
        else{
            return NULL;
	   }
	   
	}
	public function id_playlists($id){
	    $id_playlists=$this->db->query('SELECT id FROM playlist WHERE id_usuario = '.$id )->result();

	    if($this->validar_select($id_playlists)==1){
            return $id_playlists;
        }
        else{
            return NULL;
	   }
	   
	}

	public function existe_nombre($nombre){
		$existe_nombre = $this->db->query("SELECT id FROM usuario WHERE nombre = '$nombre'")->result();
		if ($this->validar_select($existe_nombre)) {
			if ($this->validar_select($existe_nombre[0])) {
				return $existe_nombre[0];
			}else{
				return $existe_nombre;
			}
		}else{
			return NULL;
		}

		/*if($this->validar_select($existe_nombre[0])==1){
            return $existe_nombre[0];
        }elseif ($this->validar_select($existe_nombre)==1) {
        	return $existe_nombre;
        }
        else{
            return NULL;
	   }*/
	}

	public function insertar_usuario($nombre, $contrasenia, $id_tipo_usuario){
		$insert = $this->db->query("INSERT INTO usuario (nombre, contrasenia, id_tipo_usuario) VALUES ('$nombre', '$contrasenia', '$id_tipo_usuario')");
		return ($this->validar_insert($insert));
	}






	public function Id_usuario($nombre, $contrasenia){
		$query = "SELECT id, id_tipo_usuario FROM usuario WHERE nombre = '$nombre' AND contrasenia = '$contrasenia'";
		return ($this->db->query($query));
	}

	public function existe_id($id){
		$existe_id = "SELECT id FROM usuario WHERE id = '$id'";
		return ($this->db->query($query));
	}

	public function Delete_usuario($id){
		$existe_id = $this->APIM->Existe_id($id);
		if (isset($existe_id->result()[0]->id)) {
			$query = "UPDATE usuario SET activo = 0 WHERE id = '$id'";
			return($this->db->query($query));
		} else 
			return FALSE;
	}
	public function ModificarT($tipo,$id){
		$modificar=$this->db->query('UPDATE usuario 
									 SET id_tipo_usuario=(SELECT id FROM tipo_usuario WHERE tipo="'.$tipo.'")
									 WHERE id='.$id);
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		FROM usuario u , tipo_usuario t
		WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
	   
		
		return  $mostrar;
	   
	}
	public function ModificarC($contrasenia,$id){
		$modificar=$this->db->query('UPDATE usuario 
									 SET contrasenia="'.$contrasenia.'"
									 WHERE id='.$id);
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		FROM usuario u , tipo_usuario t
		WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
	   
		
		return  $mostrar;
	   
	}
	public function ModificarN($nombre,$id){
		$modificar=$this->db->query('UPDATE usuario 
									 SET nombre="'.$nombre.'"
									 WHERE id='.$id);
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		FROM usuario u , tipo_usuario t
		WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
	   
		
		return  $mostrar;
	   
	}
	public function ModificarNC($nombre,$contrasenia,$id){
	   $mod_nombre=$this->APIM->ModificarN($nombre,$id);
	   $mod_contra=$this->APIM->ModificarC($contrasenia,$id);
	   
	   $mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		FROM usuario u , tipo_usuario t
		WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
	   
		
		return  $mostrar;
	   
	}
	public function ModificarNCT($nombre,$contrasenia,$tipo,$id){
		$mod_nombre=$this->APIM->ModificarN($nombre,$id);
		$mod_contra=$this->APIM->ModificarC($contrasenia,$id);
		$mod_tipo=$this->APIM->ModificarT($tipo,$id);
		
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		 FROM usuario u , tipo_usuario t
		 WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
		
		 
		 return  $mostrar;
		
	 }
	 public function ModificarNT($nombre,$tipo,$id){
		$mod_nombre=$this->APIM->ModificarN($nombre,$id);
		$mod_tipo=$this->APIM->ModificarT($tipo,$id);
		
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		 FROM usuario u , tipo_usuario t
		 WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
		
		 
		 return  $mostrar;
		
	 }
	 public function ModificarCT($contrasenia,$Tipo,$id){
		$mod_contra=$this->APIM->ModificarC($contrasenia,$id);
		$mod_tipo=$this->APIM->ModificarT($Tipo,$id);
		
		$mostrar=$result=$this->db->query('SELECT u.id as id ,u.nombre as "nombre", t.tipo as "tipo_usuario "
		 FROM usuario u , tipo_usuario t
		 WHERE t.tipo = (SELECT tipo FROM tipo_usuario WHERE id = u.id_tipo_usuario) AND u.id='.$id)->result();
		
		 
		 return  $mostrar;
		
	 }

}