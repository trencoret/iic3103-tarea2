json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :nombre, :apellido, :usuario, :twitter
  json.url usuario_url(usuario, format: :json)
end
