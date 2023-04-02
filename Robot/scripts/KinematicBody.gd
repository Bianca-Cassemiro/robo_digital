extends KinematicBody

# Constantes que definem a velocidade de movimento do player e o tempo entre atualizações
const speed = 0.5
const time = 0.0001

# Variáveis que armazenam as coordenadas e rotações atuais e futuras do player, além de sua velocidade
var current_rot := Vector3.ZERO
var target_rot := Vector3.ZERO
var current_pos := Vector3.ZERO
var target_pos := Vector3.ZERO
var velocity := Vector3.ZERO



# Função que move o player na direção correta com base em suas coordenadas atuais e futuras
func get_movement_direction(current, target, axis):
	if target > current:
		if axis == "x": velocity.x = speed
		elif axis == "y": velocity.y = speed
		elif axis == "z": velocity.z = speed
		return current + speed
	elif target < current:
		if axis == "x": velocity.x = -speed
		elif axis == "y": velocity.y = -speed
		elif axis == "z": velocity.z = -speed
		return current - speed
	else:
		if axis == "x": velocity.x = 0
		elif axis == "y": velocity.y = 0
		elif axis == "z": velocity.z = 0
		return current

# Requisição HTTP para o recebimento de dados
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8())
	# Faz uma iteração no array posições para dessa forma movimentar o personagem
	for position in positions:
		print(position)
		target_pos.x = position['x']
		print("X: ", target_pos.x)
		target_pos.y = position['y']
		print("Y: ", target_pos.y)
		target_pos.z = position['z']
		print("Z: ", target_pos.z)
		
		target_rot.x = position['rX']
		print("Rx: ", target_rot.x)
		target_rot.y = position['rY']
		print("Ry: ", target_rot.y)
		target_rot.z = position['rZ']
		print("Rz: ", target_rot.z)
		

		while (current_pos != target_pos or current_rot != target_rot):
			current_pos.x = get_movement_direction(current_pos.x, target_pos.x, "x")
			current_pos.y = get_movement_direction(current_pos.y, target_pos.y, "y")
			current_pos.z = get_movement_direction(current_pos.z, target_pos.z, "z")
			
			current_rot.x = get_movement_direction(current_rot.x, target_rot.x, "0")
			current_rot.y = get_movement_direction(current_rot.y, target_rot.y, "0")
			current_rot.z = get_movement_direction(current_rot.z, target_rot.z, "0")

			# Mostra as coordenadas atuais
			print(current_pos.x, ", ", current_pos.y, ", ", current_pos.z)
			# Mostra as rotações atuais
			print(current_rot.x, ", ", current_rot.y, ", ", current_rot.z)
			
			# Movimentação do personagem
			velocity = move_and_slide(velocity)
			
			# Rotação do personagem
			self.rotation_degrees.x = current_rot.x
			self.rotation_degrees.y = current_rot.y
			self.rotation_degrees.z = current_rot.z
			

			# Delay
			yield(get_tree().create_timer(time), "timeout")
# _on_HTTPRequest_request_completed




