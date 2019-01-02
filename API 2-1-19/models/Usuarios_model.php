<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class Usuarios_model extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}

	
    private function validar_select($query){
        if($query->conn_id->sqlstate == "00000"){
            return 1;
            #es 1 cuando el query se realizo con exito, codigo 00000
        }
        else{
            return 0;
            #es 0 cuando el query falla
        }
    }

    /* ******************** GET ********************** */
   
    public function usuarios(){
    	$usuarios=$this->db->query('SELECT id,nombre,id_tipo_usuario,activo
                                FROM usuarios' );
    	
    	if($this->validar_select($usuarios)==1){
            return $usuarios->result_array();
        }
        else{
            return NULL;
	   }
    }
    private function validar_select_usuario($query_usuario){
    	if($query_usuario->conn_id->sqlstate == "00000"){
    		#el query fue exitoso, el codigo de exito es 00000
    		$query = $query_usuario->result_array();
	    	if (count($query) == 1) {
	    		if ($query[0]['id'] > 0 && $query[0]['id_tipo_usuario'] > 0 && !empty($query[0]['nombre'])) {
	    			return 1;
	    			#es 1 cuando el query es exitoso y los valores regresados son validos
	    		}else{
	    			return 0;
	    			#es 0 cuando los valores regresados no son validos
	    		}
	    	}else{
	    		return 0;
	    		#es 0 cuando manda mas de un resultado o ningun resultado
	    	}
	    }else{
	    	return 0;
	    	#es 0 cuando el query falla
	    }
    }

	public function login($nombre,$contrasenia){
	    $query_usuario=$this->db->query('SELECT id,nombre,id_tipo_usuario 
                                  FROM usuarios 
                                  WHERE nombre="'.$nombre.'"
                                  AND contrasenia="'.$contrasenia.'"');
	 
        if($this->validar_select_usuario($query_usuario)==1){
            $usuario=array(
                'id' => $query_usuario->result_array()[0]['id'],
                'nombre' => $query_usuario->result_array()[0]['nombre'],
                'id_tipo' => $query_usuario->result_array()[0]['id_tipo_usuario']);
            return $usuario;
        }
        else{
            return 0;
            #es 0 cuando el query falla
	   }
	}
	public function ver_playlists($id){
	    
		$query = 'SELECT playlists.id, playlists.nombre,  COUNT(*) AS numero_de_canciones, JSON_ARRAYAGG(JSON_OBJECT("id",canciones.id,
				"nombre",canciones.nombre,"artista",artistas.nombre,"album",albums.nombre,"direccion",canciones.direccion)) AS "canciones"
				  FROM playlist_con_canciones
				    INNER JOIN playlists ON playlists.id = playlist_con_canciones.id_playlist
				    INNER JOIN canciones ON canciones.id = playlist_con_canciones.id_cancion
				    INNER JOIN artistas ON artistas.id = canciones.id_artista
				    INNER JOIN albums ON albums.id = canciones.id_album
				  WHERE
				    playlists.id_usuario = "'.$id.'"
				  GROUP BY playlists.id;';
	    $playlists = $this->db->query($query);

	    if ($this->validar_select($playlists)==1) {
	    	return $playlists->result_array();
	    }else{
	    	return 0;
	    	#es 0 cuando el query falla
	    }
	}
	public function id_playlists($id){
	    $id_playlists=$this->db->query('SELECT id FROM playlists WHERE id_usuario = '.$id );
	    #campo de existo o no, sin result
	    if($this->validar_select($id_playlists)==1){
            return $id_playlists->result_array();
        }
        else{
            return 0;
            #es 0 cuando el query falla
	    }
	   
	}

	/* ******************** POST ********************** */

	private function validar_select_nombre($query){
    	if($query->conn_id->sqlstate == "00000"){
    		#el query fue exitoso, el codigo de exito es 00000
    		$query = $query->result_array();
	    	if (count($query) > 0) {
	    		if ($query[0]['id'] > 0) {
	    			return 1;
	    			#es 1 cuando existe el nombre y el id es >0
	    		}else{
	    			return 0;
	    			#es 0 cuando el id no es >0
	    		}
	    	}else{
	    		return 2;
	    		#es 2 cuando no existe el nombre
	    	}
	    }else{
	    	return 0;
	    	#es 0 cuando el query falla
	    }
    }
    private function validar_insert($query){
    	if ($query == TRUE) {
    		return 1;
    		#es 1 cuando el query se realizo con exito
    	}else{
    		return 0;
    		#es 0 cuando el query falla
    	}
    }

	public function existe_nombre($nombre){
		$existe_nombre = $this->db->query("SELECT id FROM usuarios WHERE nombre = '$nombre'");
		$exito_query = $this->validar_select_nombre($existe_nombre);
		return $exito_query;
	}

	public function insertar_usuario($nombre, $contrasenia, $id_tipo_usuario){
		$insert = $this->db->query("INSERT INTO usuarios (nombre, contrasenia, id_tipo_usuario) VALUES ('$nombre', '$contrasenia', '$id_tipo_usuario')");
		return ($this->validar_insert($insert));
	}


	/* ******************** DELETE ********************** */

	private function validar_update(){
	    if($this->db->affected_rows() == 1){
			#el update realizo algun cambio
	        return 1;
	    }else{
			#el update fallo
	        return 0;
	    }
    }

	public function delete_usuario($id){
		$query = $this->db->query("UPDATE usuarios SET activo = 0 WHERE id = ".$id);
		//return $this->db->affected_rows();
		if($this->validar_update()==1){
			#tiene exito, se elimino logicamente el usuario
			return 1;
		}
		else{
			#el query falla y no se elimina el usuario
			return 0;
		}
	}

	/* ******************** PUT ********************** */

	public function modificar_todo($id,$nombre,$contrasenia,$id_tipo){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET nombre="'.$nombre.'", 
												contrasenia="'.$contrasenia.'", 
												id_tipo_usuario="'.$id_tipo.'"
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_nombre($id,$nombre){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET nombre="'.$nombre.'" 	
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_contrasenia($id,$contrasenia){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET contrasenia="'.$contrasenia.'" 	
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_tipo_usuario($id,$id_tipo){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET id_tipo_usuario="'.$id_tipo.'"
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_nombre_contrasenia($id,$nombre,$contrasenia){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET nombre="'.$nombre.'", 
												contrasenia="'.$contrasenia.'" 
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_nombre_tipo($id,$nombre,$id_tipo){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET nombre="'.$nombre.'", 
												id_tipo_usuario="'.$id_tipo.'"
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}
	public function modificar_contasenia_tipo($id,$contrasenia,$id_tipo){
		$modificar_usuario=$this->db->query('UPDATE usuarios 
											SET contrasenia="'.$contrasenia.'", 
												id_tipo_usuario="'.$id_tipo.'"
											WHERE id='.$id);
		#validamos que su halla modificado algo
		if($this->validar_update()==1){
			#se modifico el usuario
			return 1;
		}
		else{
			#no se pudo modificar
			return 0;
		}
	}

}