typealias JSON MIME"application/json"

function Base.writemime(io::IO, m::JSON, dict::Dict)
  write(io, '{')
  items = collect(dict)
  if !isempty(items)
    for (key,value) in items[1:end-1]
      write(io, "\"$key\":")
      writemime(io, "application/json", value)
      write(io, ',')
    end
    write(io, "\"$(items[end][1])\":")
    writemime(io, "application/json", items[end][2])
  end
  write(io, '}')
end

function Base.writemime(io::IO, ::JSON, array::Array)
  write(io, '[')
  if !isempty(array)
    for value in array[1:end-1]
      writemime(io, "application/json", value)
      write(io, ',')
    end
    writemime(io, "application/json", array[end])
  end
  write(io, ']')
end

function Base.writemime(io::IO, ::JSON, s::String)
  write(io, '"')
  print_escaped(io, s, "\"")
  write(io, '"')
end

Base.writemime(io::IO, ::JSON, n::Real) = write(io, string(n))
Base.writemime(io::IO, ::JSON, b::Bool) = write(io, string(b))
