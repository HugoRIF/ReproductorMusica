<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Musica extends CI_Controller {
	function __construct(){
		parent::__construct();
		
		$this->load->helper('url');
		$this->load->model('LoginM');
		$this->load->library('session');
	}

	public function index()
	{
		$this->load->view('musica/header');
		$this->load->view('musica/principal');
	}
	public function login(){
		#Recuperamos datos del form y los guardamos en un arreglo
		$data = array(
				'usuario' => $this->input->post('usuario'),
				'contra' => $this->input->post('contra')
			);
		#Validamos que no esten vacios los campos, se mandan alerts
		if($data['usuario']==""){
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
			echo '<script>alert("Ingresa un usuario");</script>';
		}
		elseif($data['contra']==""){
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
			echo '<script>alert("Ingresa una Contraseña");</script>';
		}
		#Si no estan vacios...
		else{
			#Checamos en el modelo si eciste el usuario 
			$idTipo_Usuario=$this->LoginM->Checar_Usuario($data);
			if($idTipo_Usuario == 1){
				#existe como Administrador
				#recupero el id del usuario y se guarda la session
				$idUsuario=$this->LoginM->Regresa_idUsuario($data);
				$usuario_data = array(
					'id' => $idUsuario,
					);
				$this->session->set_userdata($usuario_data);
				#echo($this->session->userdata('id'));
				#echo("Admin");
				$this->load->view('musica/header');
				$this->load->view('Administrador/inicioAdmin',$data);
			}
			elseif($idTipo_Usuario == 2){
				#existe como Usuario
				#recupero el id del usuario y se guarda la session
				$idUsuario=$this->LoginM->Regresa_idUsuario($data);
				$usuario_data = array(
					'id' => $idUsuario,
					);
				$this->session->set_userdata($usuario_data);
				$idUser = $this->session->userdata('id');
				$aux = $this->LoginM->numeroPlay($idUser);
				$idsPlay = $this->LoginM->idsPlay($idUser);
				if ($idsPlay->num_rows() == 1) {
					$play1 = $idsPlay->result()[0]->id;
					$data['play1'] = $this->LoginM->InfoPlay($play1);
				}if ($idsPlay->num_rows() == 2){
					$play1 = $idsPlay->result()[0]->id;
					$play2 = $idsPlay->result()[1]->id;
					$data['play1'] = $this->LoginM->InfoPlay($play1);
					$data['play2'] = $this->LoginM->InfoPlay($play2);
				}
		
				$data['numPlay'] = $aux;
				$this->load->view('musica/header');
				$this->load->view('Usuario/inicioUsuario',$data);
			}else{
				#El usuario no existe
				$this->load->view('musica/header');
				$this->load->view('musica/principal');
				echo '<script>alert("Usuario sin registro");</script>';
			}
		}
	}

	function Salir(){
		$this->session->sess_destroy();
		$this->load->view('musica/header');
		$this->load->view('musica/principal');
	}
}
