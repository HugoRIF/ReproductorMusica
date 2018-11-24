<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class AdmiM extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
    }
    function Mostrar_Canciones(){
        $result=$this->db->query('SELECT `nombreCancion`
                                  FROM `Cancion`
                                  ORDER BY `id` ')->result();
       $arrayNombreC = array('');
       $i=0;
        foreach ($result as $res) { 
           array_push($arrayNombreC,$result[$i]->nombreCancion);
           $i++;
       }
       return $arrayNombreC ;
       
   }
   function Mostrar_Artistas(){
    $result=$this->db->query('SELECT nombreArtista 
                            FROM Artista a, Cancion c 
                            WHERE c.idArtista = a.id 
                            ORDER BY c.id')->result();
   $arrayNombreA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreArtista);
       $i++;
   }
   return $arrayNombreA ;
   
}
function Mostrar_Album(){
    $result=$this->db->query('SELECT nombreAlbum 
                            FROM Album a, Cancion c 
                            WHERE c.idAlbum = a.id 
                            ORDER BY c.id')->result();
   $arrayNombreA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreAlbum);
       $i++;
   }
   return $arrayNombreA ;
   
}
function Mostrar_idArtistas(){
    $result=$this->db->query('SELECT a.id
                            FROM Artista a, Cancion c 
                            WHERE c.idArtista = a.id 
                            ORDER BY c.id')->result();
   $arrayidA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayidA,$result[$i]->id);
       $i++;
   }
   return $arrayidA ;
   
}
function nomArtista_porID($id){
    $result=$this->db->query('SELECT nombreArtista 
                            FROM Artista  
                            WHERE id ='.$id)->result();
   $NombreA = $result[0]->nombreArtista;
      
   return $NombreA ;
   
}
public function Mostrar_Canciones_Artista($id){
    $result=$this->db->query('SELECT `nombreCancion`
                              FROM `Cancion`
                              WHERE `idArtista`='.$id)->result();
   $arrayNombreC = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreC,$result[$i]->nombreCancion);
       $i++;
   }
   return $arrayNombreC ;
   
}
function Mostrar_Album_ArrCancion($id){
    $result=$this->db->query('SELECT a.nombreAlbum
                                FROM Cancion c, Album a 
                                WHERE c.idArtista='.$id.'
                                AND c.idAlbum = a.id ')->result();
    $arrayNombreC = array('');
    $i=0;
    foreach ($result as $res) { 
    array_push($arrayNombreC,$result[$i]->nombreAlbum);
    $i++;
    }  
    
    return  $arrayNombreC;
   
}

function Mostrar_Albunes_Artista($id){
    $result=$this->db->query('SELECT nombreAlbum,añoAlbum,numCancAlbum 
                            FROM Album 
                            WHERE idArtista ='.$id)->result();
   $arrayAAlbum = array('');
   $arrayNombreA = array('');
   $arrayNumCA = array('');
   $arrayInfoA = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayNombreA,$result[$i]->nombreAlbum);
       array_push($arrayAAlbum,$result[$i]->añoAlbum);
       array_push($arrayNumCA,$result[$i]->numCancAlbum);
       
       $i++;
   }
    array_push($arrayInfoA,$arrayNombreA);
    array_push($arrayInfoA,$arrayNumCA);
    array_push($arrayInfoA,$arrayAAlbum);
   
       
   return $arrayInfoA ;
   
}
function Mostrar_idUsuarios($idSesion){
    $result=$this->db->query('SELECT id
                              FROM Usuario
                              WHERE id!='.$idSesion.'
                              ORDER BY `id` ')->result();
   $arrayidU = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayidU,$result[$i]->id);
       $i++;
   }
   return $arrayidU ;
   
}
function Mostrar_nomUsuarios($idSesion){
    $result=$this->db->query('SELECT nombreUsuario
                              FROM Usuario
                              WHERE id!='.$idSesion.'
                              ORDER BY `id` ')->result();
   $arrayidU = array('');
   $i=0;
    foreach ($result as $res) { 
       array_push($arrayidU,$result[$i]->nombreUsuario);
       $i++;
   }
   return $arrayidU ;
   
}
function Registrar_Usuario($data){
    #Primero checo si el nombre de usuario NO esta ocupado
    $queryChecaU=$this->db->query('SELECT nombreUsuario
                                    FROM Usuario
                                    WHERE nombreUsuario="'.$data['usuario'].'"');
    if($queryChecaU->num_rows() > 0){
        return 0;
    }
    else{

            $queryTipo=$this->db->query('SELECT id
                                    FROM TipoUsuario
                                    WHERE nombreTipoUsuario="'.$data['tipo'].'"')->result();
            $idTipo=$queryTipo[0]->id;

            $result=$this->db->query('INSERT INTO Usuario(nombreUsuario, contraUsuario, idTipoUsuario)
            VALUES ("'.$data['usuario'].'","'.$data['contra'].'",'.$idTipo.')');
            return 1;
        }
   
}
function Editar_Usuario($data){
    

            $queryTipo=$this->db->query('SELECT id
                                    FROM TipoUsuario
                                    WHERE nombreTipoUsuario="'.$data['tipo'].'"')->result();
            $idTipo=$queryTipo[0]->id;

            $result=$this->db->query('UPDATE Usuario 
                                        SET nombreUsuario="'.$data['nomU'].'",
                                            `contraUsuario`="'.$data['contra'].'",
                                            `idTipoUsuario`='.$idTipo.'
                                        WHERE id='.$data['UsuarioID']);
            
        if($result){
            return 1;
        }else{
            return 0;
        }
   
}
function Mostrar_nomUsuario_porID($id){
    $result=$this->db->query('SELECT nombreUsuario
                                FROM Usuario 
                                WHERE id='.$id)->result();
    $nomU=$result[0]->nombreUsuario;
   
    
    return  $nomU;
   
}

}