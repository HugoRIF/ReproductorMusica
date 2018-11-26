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
    function Mostrar_Generos(){
        $result=$this->db->query('SELECT nombreGenero 
                                    FROM Genero 
                                    ORDER BY id')->result();
        $arrayNombreG = array('');
        $i=0;
            foreach ($result as $res) { 
            array_push($arrayNombreG,$result[$i]->nombreGenero);
            $i++;
        }
        return $arrayNombreG ;
        
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
function Eliminar_Usuario($id){
    $qTipo=$this->db->query('SELECT idTipoUsuario
                                FROM Usuario
                                WHERE id='.$id)->result();

   $idTipo=$qTipo[0]->idTipoUsuario;
if($idTipo==1){
    $eliminarA=$this->db->query('DELETE FROM `Usuario` WHERE id='.$id);

    return 1;
}else{
    $eliminarU_playlist=$this->db->query('SELECT id
                                            FROM Playlist 
                                            WHERE idUsuario='.$id)->result();
    $arrayidpl = array('');
    $i=0;
    foreach ($eliminarU_playlist as $res) { 
       array_push($arrayidpl,$eliminarU_playlist[$i]->id);
       $i++;
     }
     $j=0;
    foreach ($arrayidpl as $res) { 
       
        $eliminarpl_c=$this->db->query('DELETE FROM Playlist_Cancion WHERE idPlaylist='.$arrayidpl[$j]);
       
       $j++;
     }
     $k=0;
     foreach ($arrayidpl as $res) { 
        
         $eliminarpl_c=$this->db->query('DELETE FROM Playlist WHERE id='.$arrayidpl[$k]);
        
        $k++;
      }
      $eliminarU=$this->db->query('DELETE FROM `Usuario` WHERE id='.$id);
return 2;
}

}
function Mostrar_nomUsuario_porID($id){
    $result=$this->db->query('SELECT nombreUsuario
                                FROM Usuario 
                                WHERE id='.$id)->result();
    $nomU=$result[0]->nombreUsuario;
   
    
    return  $nomU;
   
}
function Agregar_Cancion($Arr){
    #primero checamos que el ARTISTA exista
    $ChecaArtista=$this->db->query('SELECT id
                                    FROM Artista
                                    WHERE nombreArtista="'.$Arr['Artista'].'"');
    if($ChecaArtista->num_rows() > 0){
        #si existe el ARTISTA
        #Checamos que exista el ALBUM 
        $ChecaAlbum=$this->db->query('SELECT id
                                    FROM Album
                                    WHERE nombreAlbum="'.$Arr['Album'].'"');
        if($ChecaAlbum->num_rows() > 0){
             #si existe el ALBUM
            #Checamos si existe la CANCION
            $ChecaCancion=$this->db->query('SELECT id
                                        FROM Cancion
                                        WHERE nombreCancion="'.$Arr['Cancion'].'"');
            if($ChecaCancion->num_rows() > 0){
                return 0;#La CANCION ya existe
            }else{
                #La CANCION no existe, INSERTAMOS
                $InsertCancion=$this->db->query('INSERT INTO Cancion
                                                 ( nombreCancion,idAlbum, idArtista,idGenero,direccionCancion)
                                                 VALUES ("'.$Arr['Cancion'].'",
                                                            (SELECT id
                                                            FROM Album
                                                            WHERE nombreAlbum="'.$Arr['Album'].'"),
                                                            (SELECT id
                                                            FROM Artista
                                                            WHERE nombreArtista="'.$Arr['Artista'].'"),
                                                            (SELECT id
                                                            FROM Genero
                                                            WHERE nombreGenero="'.$Arr['Genero'].'"),
                                                            "http://192.168.64.2/opt/lampp/htdocs/RPrueba/canciones/WhenYouWhereYoung.mp3" )');
                #Actualizo el numero de canciones en el album 

                $ActNumCAnc=$this->db->query('UPDATE Album set numCancAlbum=numCancAlbum+1 WHERE nombreAlbum="'.$Arr['Album'].'"');
                return 1;
            }
        }else{
            #No existe el album, INSERTAMOS el ALBUM
            $InsertAlbum=$this->db->query('INSERT INTO Album
                                                 ( nombreAlbum,numCancAlbum, idArtista)
                                                 VALUES ("'.$Arr['Album'].'",
                                                            1,
                                                            (SELECT id
                                                            FROM Artista
                                                            WHERE nombreArtista="'.$Arr['Artista'].'")
                                                            )');
            #insertamos cancion
            $InsertCancion=$this->db->query('INSERT INTO Cancion
            ( nombreCancion,idAlbum, idArtista,idGenero,direccionCancion)
            VALUES ("'.$Arr['Cancion'].'",
                       (SELECT id
                       FROM Album
                       WHERE nombreAlbum="'.$Arr['Album'].'"),
                       (SELECT id
                       FROM Artista
                       WHERE nombreArtista="'.$Arr['Artista'].'"),
                       (SELECT id
                       FROM Genero
                       WHERE nombreGenero="'.$Arr['Genero'].'"),
                       "http://192.168.64.2/opt/lampp/htdocs/RPrueba/canciones/WhenYouWhereYoung.mp3" )');

            return 2;
        }
    }else{
        #No existe el Artista, INSERTAMOS el ARTISTA
        $InsertArtista=$this->db->query('INSERT INTO Artista( nombreArtista)
        VALUES ("'.$Arr['Artista'].'")');
        
        #INSERTAMOS el ALBUM
        $InsertAlbum=$this->db->query('INSERT INTO Album
        ( nombreAlbum,numCancAlbum, idArtista)
        VALUES ("'.$Arr['Album'].'",
                   1,
                   (SELECT id
                   FROM Artista
                   WHERE nombreArtista="'.$Arr['Artista'].'")
                   )');
        #insertamos cancion
        $InsertCancion=$this->db->query('INSERT INTO Cancion
        ( nombreCancion,idAlbum, idArtista,idGenero,direccionCancion)
        VALUES ("'.$Arr['Cancion'].'",
                   (SELECT id
                   FROM Album
                   WHERE nombreAlbum="'.$Arr['Album'].'"),
                   (SELECT id
                   FROM Artista
                   WHERE nombreArtista="'.$Arr['Artista'].'"),
                   (SELECT id
                   FROM Genero
                   WHERE nombreGenero="'.$Arr['Genero'].'"),
                   "http://192.168.64.2/opt/lampp/htdocs/RPrueba/canciones/WhenYouWhereYoung.mp3" )');

        return 3;
    }
}

}