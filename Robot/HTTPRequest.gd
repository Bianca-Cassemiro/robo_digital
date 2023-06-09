extends HTTPRequest

# Função que roda no início do programa, que faz o requerimento HTTP
func _ready():
	self.connect("request_completed", self, "_on_request_completed")
	var err = self.request("http://127.0.0.1:5000/create")
	if err != OK:
		push_error("Um erro ocorreu!")

# Se o requerimento tiver sucesso, mostrará os valores lidos
func _on_request_completed(result, response_code, headers, body):
	var positions = parse_json(body.get_string_from_utf8())
	print(positions)
