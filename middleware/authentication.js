const jwt = require("jsonwebtoken");

module.exports.isAuthorized = (req, res, next) => {
    let token = req.headers.authorization ? req.headers.authorization.split(' ')[1] : req.query.token
    if (!!token) {
        try {
            let v = jwt.verify(token, process.env.JWT_SECRET, {
                ignoreExpiration: false,
                ignoreNotBefore: false
            });
            req.user = { ...v.sub }
            next(); // this is where the get /api/users executed 
        } catch (error) {
            return res.status(403).json({ success: false, message: 'Failed to authenticate token.', error });
        }
    }
    else {
        return res.status(403).send({ success: false, message: 'No token provided.' });
    }
};
