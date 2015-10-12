json.array!(@savedprograms) do |savedprogram|
  json.extract! savedprogram, :id, :program_id, :trainer_id
  json.url savedprogram_url(savedprogram, format: :json)
end
