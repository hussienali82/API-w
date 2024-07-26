const jwt = require('jsonwebtoken')
require('dotenv')

//get token -----------------------------------------
const getToken = sub => {
    const token = jwt.sign({ sub }, process.JWT_SECRET, {
        algorithm: 'HS256',
        expiresIn: 28800
    })
    return token;
}

//verify message ------------------------------------
const verifyMsg = (Verify, Msg, Token) => {
    const message = {
        verify: Verify,
        msg: Msg,
        token: Token
    }
    return message
}

//verify token --------------------------------------
const verifyToken =(req)=>{
    var payload
    var token
    const headerToken = req.headers.authorization
    if (!headerToken) return verifyMsg(false,"No token")
    const bearerToken = headerToken.split(" ")
    token = bearerToken[1]
    try {
        payload = jwt.verify(bearerToken[1],process.env.JWT_SECRET)
    } catch (error) {
        if (error instanceof jwt.JsonWebTokenError) {
            return verifyMsg(false,"Unauthorized token")
        }
        return verifyMsg(false,"Invalid token")
    }
    return verifyMsg(true,payload.sub,token)
}

//export functions ------------------------------------
module.exports.getToken = getToken
module.exports.verifyToken = verifyToken