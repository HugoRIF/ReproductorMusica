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
public function EditarU(){
	$idUeditar=$this->input->get('idUsuario');
	$data = array(
		'UsuarioID' => $idUeditar,
		'nomU' => $this->AdmiM->Mostrar_nomUsuario_porID($idUeditar),
				
	);
	
	$AUsuario=$this->load->view('Administrador/EditarUsuario',$data);
	return $AUsuario;
}
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
public function AgregarU(){
	$Sesionid=$this->session->userdata('id');
       
       $AUsuario=$this->load->view('Administrador/AgregarUsuario');
       return $AUsuario;
       }
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
}