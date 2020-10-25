
function qr(txt::String)
    return Gray.(convert.(Float64, .!(qrcode(txt))))
end

function plainqr(txt::String)
    return qrcode(txt)
end
