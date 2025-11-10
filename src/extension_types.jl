struct QRC{T<:AbstractString,I<:Number}
    payload::T
    size::I
end
QRC(s) = QRC(s, 200)
