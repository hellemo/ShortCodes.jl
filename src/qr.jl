

function qr(txt::String)
    Gray.(convert.(Float64,.!(qrcode(txt))))
end

function plainqr(txt::String)
    qrcode(txt)
end
