<?php if(! defined('BASEPATH')) exit ('No direct script access allowed');

class LoginM extends CI_Model{
	function __construct(){
		parent :: __construct();
		$this->load->database();
	}
	function Checar_Usuario($data){
		
		
		$query = $this->db->query('SELECT idtipousuario 
									FROM `usuario`
									 WHERE nombreusuario ="'.$data['usuario'].'"
									AND contrausuario ="'.$data['contra'].'"');
		$tipoU="";
		if($query->num_rows())
		{
			
			$query2 = $query->result();
			$tipoU = $query2[0]->idtipousuario;
			return $tipoU;
		}else{
			return 0;
		}
		
	}
	function Regresa_idUsuario($data){
		
		
		$query = $this->db->query('SELECT id
									FROM `usuario`
									 WHERE nombreusuario ="'.$data['usuario'].'"
									AND contrausuario ="'.$data['contra'].'"')->result();
		
		$idU = $query[0]->id;
			return $idU;
		
	}
	
}
