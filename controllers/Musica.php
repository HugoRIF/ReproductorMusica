<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Musica extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */
	function __construct(){
		parent::__construct();
		$this->load->helper('form');
		$this->load->helper('url');
		$this->load->model('PruebasBD');
	}

	public function index()
	{
		$this->load->view('musica/header');
		$this->load->view('musica/principal');
		
	}
	public function login(){
		$data = array(
				'usuario' => $this->input->post('usuario'),
				'contra' => $this->input->post('contra')
			);
		if($data['usuario']==""){
			echo '<script>alert("Ingresa un usuario");</script>';
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
		}
		elseif($data['contra']==""){
			echo '<script>alert("Ingresa una Contraseña");</script>';
			$this->load->view('musica/header');
			$this->load->view('musica/principal');
		}else{

		}
		//$this->load->view('musica/header');
		//$this->load->view('musica/info', $data);
	}
}
