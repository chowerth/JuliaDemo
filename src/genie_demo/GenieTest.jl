using Genie, Genie.Router, Genie.Renderer.Json, Genie.Requests
using HTTP
using JSON3


Genie.config.run_as_server = true

route("/") do
    # Dictionary symbol syntax
  (:message => "Hi there!") |> json
end

route("/hello") do 
    name::String = params(:name, "Default")
    Dict{String, String}("message" => "Hello " * name) |> json
end

route("/echo", method = POST) do
    @show rawpayload()
    JSON3.pretty(rawpayload())
    @show jsonpayload()
    payload = jsonpayload()
    (:echo => (payload["message"] * " ") ^ payload["repeat"]) |> json
  end
  
  route("/send") do
    headers = [("Content-Type", "application/json")]
    body = JSON3.write(Dict("message" => "hello", "repeat" => 7))
    @show body
    response = HTTP.post("http://localhost:8000/echo", headers, body)
  end

Genie.startup()