extends Node

var api_key : String = "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"
var url : String = "https://api.openai.com/v1/chat/completions"
var temperature : float = 0.5
var max_tokens : int = 1024
var headers = ["Content-type: application/json", "Authorization: Bearer " + api_key]
var model : String = "gpt-3.5-turbo"
var request : HTTPRequest

@export_multiline var dialogue_rules : String

signal on_player_talk
signal on_npc_talk (npc_dialogue)
signal appendMessage(message)

func _ready ():
	request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed", _on_request_completed)

		
# called when we want to talk to the AI
func dialogue_request ( messages):
	on_player_talk.emit()
	
	# create the request body
	var body = JSON.new().stringify({
		"messages": messages,
		"temperature": temperature,
		"max_tokens": max_tokens,
		"model": model
	})
	
	# send the request to the AI server
	var send_request = request.request(url, headers, HTTPClient.METHOD_POST, body)
	
	# if there was a problem, make it known
	if send_request != OK:
		print("There was an error!")

# called when we have received a response from the server
func _on_request_completed (result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	var message = response["choices"][0]["message"]["content"]
	
	appendMessage.emit({
		"role": "system",
		"content": message
	})
	
	
	on_npc_talk.emit(message)

