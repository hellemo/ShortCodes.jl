struct QR{T<:AbstractString,I<:Number}
    payload::T
    size::I
end
QR(s) = QR(s, 100)
