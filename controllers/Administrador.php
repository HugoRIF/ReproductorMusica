<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Administrador extends CI_Controller {
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('AdmiM');
		$this->load->library('session');
	}
	public function index(){
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');
    
	}
#Cargar vista con las CANCIONES--------------------------------------------------
	public function Canciones(){
	$datos=array(
		'Nombre'=>$this->AdmiM->Mostrar_Canciones(),
		'Artista'=>$this->AdmiM->Mostrar_Artistas(),
		'Album'=>$this->AdmiM->Mostrar_Album(),
		'idArtista'=>$this->AdmiM->Mostrar_idArtistas(),
	);
	$ACancion=$this->load->view('Administrador/AdminCanciones',$datos);
        return $ACancion;
	}

#Cargar vista con los--------------------------------------------------
	public function Usuarios(){
	 $Sesionid=$this->session->userdata('id');
	$datos=array(
		'idUsuarios'=>$this->AdmiM->Mostrar_idUsuarios($Sesionid),
		'nomUsuarios'=>$this->AdmiM->Mostrar_nomUsuarios($Sesionid),
	);
	$AUsuario=$this->load->view('Administrador/AdminUsuarios',$datos);
        return $AUsuario;
	}
	public function Artista_Especifico(){
		$ArtistaID=$this->input->get('idArtista');
		$data = array(
			'ArtistaID' => $ArtistaID,
			'Canciones' => $this->AdmiM->Mostrar_Canciones_Artista($ArtistaID),
			'nomArtista' => $this->AdmiM->nomArtista_porID($ArtistaID),
			'AlbunesC' => $this->AdmiM->Mostrar_Album_ArrCancion($ArtistaID),
			
		);
		
	$AUsuario=$this->load->view('Administrador/ArtistaEsp',$data);
		return $AUsuario;
		}
#Cargar vista con EDITAR USUARIO--------------------------------------------------
	public function EditarU(){
		$idUeditar=$this->input->get('idUsuario');
		$data = array(
			'UsuarioID' => $idUeditar,
			'nomU' => $this->AdmiM->Mostrar_nomUsuario_porID($idUeditar),
					
		);
		
		$AUsuario=$this->load->view('Administrador/EditarUsuario',$data);
		return $AUsuario;
	}

#RECIBIR datos con el usuario a EDITAR--------------------------------------------------
	public function Editar_Usuario(){
	
		$data = array(
			'UsuarioID' => $this->input->post('idUE'),
			'nomU' => $this->input->post('usuario'),
			'contra' => $this->input->post('contra'),
			'tipo' => $this->input->post('Tipo'),
		);
		$respuesta=$this->AdmiM->Editar_Usuario($data);
		if($data['nomU']==""){
			echo '<script>alert("Ingresa un usuario");</script>';
			$this->load->view('musica/header');
			$this->load->view('Administrador/inicioAdmin');

		}
		elseif($data['contra']==""){
			echo '<script>alert("Ingresa una Contraseña");</script>';
			$this->load->view('musica/header');
			$this->load->view('Administrador/inicioAdmin');

		}
		#Si no estan vacios...
		else{
		if($respuesta==1){
			echo '<script>alert("Se actualizo el usuario");</script>';
			$this->load->view('musica/header');
			$this->load->view('Administrador/inicioAdmin');

				
		}else{
			echo '<script>alert("No se pudo actualizar");</script>';
			$this->load->view('musica/header');
			$this->load->view('Administrador/inicioAdmin');

		}
		}
	}
#Cargar vista con ELIMINAR USUARIO--------------------------------------------------
public function EliminarU(){
	$idUeditar=$this->input->get('idUsuario');
	$data = array(
		'UsuarioID' => $idUeditar,
		'PlaylistsID' => $this->AdmiM->Mostrar_nomUsuario_porID($idUeditar),
		'nomU' => $this->AdmiM->Mostrar_nomUsuario_porID($idUeditar),
					
	);
	
	$AUsuario=$this->load->view('Administrador/EliminarUsuario',$data);
	return $AUsuario;
}
#RECIBIR datos con el usuario a ELIMINAR--------------------------------------------------
public function Eliminar_Usuario(){
	
	
		$ID = $this->input->post('idUE');
		
	
	$respuesta=$this->AdmiM->Eliminar_Usuario($ID);
	if($respuesta==1){
		echo '<script>alert("Se Elimino el ADMINISTRADOR");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

			
	}elseif($respuesta==2){
		echo '<script>alert("Se Elimino el USUARIO");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

	}else{
		echo '<script>alert("NO se puede eliminar, Intenta más tarde");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

	}
}

#Cargar vista con AGREGAR USUARIO--------------------------------------------------
public function AgregarU(){
	$Sesionid=$this->session->userdata('id');
       
       $AUsuario=$this->load->view('Administrador/AgregarUsuario');
       return $AUsuario;
       }

#RECIBIR DATOS para AGREGAR USUARIO--------------------------------------------------
public function Agregar_Usuario_Nuevo(){
	$data = array(
		'usuario' => $this->input->post('usuario'),
		'contra' => $this->input->post('contra'),
		'tipo' => $this->input->post('Tipo')
		
	);

	$Sesionid=$this->session->userdata('id');
	$respuesta=$this->AdmiM->Registrar_Usuario($data);
	if($data['usuario']==""){
		echo '<script>alert("Ingresa un usuario");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

	}
	elseif($data['contra']==""){
		echo '<script>alert("Ingresa una Contraseña");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

	}
	#Si no estan vacios...
	else{
	if($respuesta==1){
		echo '<script>alert("Registro Exitoso");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

			
	}else{
		echo '<script>alert("Intenta con otro Nombre de Usuario");</script>';
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');

	}
	}
       }
       public function AgregarC(){
	$data = array(
		'Genero' => $this->AdmiM->Mostrar_Generos(),
					
	);
       $ACancion=$this->load->view('Administrador/AgregarCancion',$data);
       return $ACancion;
       }
       public function Subir_Cancion(){
		#Recibo datos del formulario
		$datosC=array(
			'Cancion' => $this->input->post('Cancion'),

			'Artista' => $this->input->post('Artista'),

			'Album' => $this->input->post('Album'),

			'Genero' => $this->input->post('Genero'),
		);

	/* las configuraciones de la carpeta y los archivos que va aceptar subir
	  -debemos crear la carpeta que recibe en el root del proyecto.
	  -tipos de archivos permitidos mp3.
	  -tamaño maximo 100kb
	  -maximo ancho 1024
	  -maximo alto 768
	  */
	  $config['upload_path'] = './canciones/';
	  $config['allowed_types'] = 'mp3';
	  $config['max_size'] = '1000000';
	  $config['max_width']  = '1024';
	  $config['max_height']  = '768';
    
	  /* cargamos la libreria de codeigniter upload
	   esta nos ayudara  a gestionar de manera sencilla la subida
	   del archivo.
	  */
	  $this->load->library('upload', $config);
    
	  /*verifica si existe error */
    
	  if ( ! $this->upload->do_upload())
	  {
	   /* error en la subida del archivo */
    	   echo '<script>alert("UPPS Algo salio mal intenta de nuevo");</script>';
	   $this->load->view('musica/header');
	   $this->load->view('Administrador/inicioAdmin');
	  }
	  else
	  {
	   /* éxito en la subida del archivo */
		$agregaCancion=$this->AdmiM->Agregar_Cancion($datosC);
		switch ($agregaCancion) {
			case 0:
			echo '<script>alert("La cancion ya existe");</script>';
			break;
			case 1:
			echo '<script>alert("cancion Agreada");</script>';
			break;
			case 2:
			echo '<script>alert("cancion y Album creados");</script>';
			break;
			case 3:
			echo '<script>alert("Cancion,Album y Artista creados");</script>';
			break;
			default:
				
				break;
		}
	   echo($datosC['Artista']);
	   echo($datosC['Album']);
	   echo($datosC['Cancion']);
	   echo($datosC['Genero']);
		$this->load->view('musica/header');
		$this->load->view('Administrador/inicioAdmin');
	  }
       }
}
