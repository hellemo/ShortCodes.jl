module QRCodersExt

using LinearAlgebra
using QRCoders
using ShortCodes

function _to_ascii(A, TRUE="██", FALSE="  ")
    join((join( b ? TRUE : FALSE for b in r ) for r in eachrow(A)),"\n")
end

function Base.show(io::IO, ::MIME"image/png", q::ShortCodes.QR)
    bitmap = .!qrcode(q.payload)
    N = Int(round(q.size / size(bitmap, 1)))
    bitmap = kron(bitmap, ones(Bool, N, N))
    QRCoders.FileIO.save(QRCoders.FileIO.Stream(QRCoders.FileIO.format"PNG", io), bitmap)
end

function Base.show(io::IO, ::MIME"text/plain", q::ShortCodes.QR)
    print(io, _to_ascii(qrcode(q.payload)))
end


end