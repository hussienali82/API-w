const { verifyToken } = require('./jwt');
const { notifyMessage } = require('../utils/notification');
//token middleware
module.exports = {
    checkToken: () => {
        return (req, res, next) => {
            try {
                const checkToken = verifyToken(req);
                if (checkToken.verify) {
                    next();
                } else {
                    res.status(400).json(notifyMessage(false, 'Unauthorized Access', '', checkToken.msg));
                }
            } catch (error) {
                res.status(400).json(notifyMessage(false, 'Unauthorized Access', '', error));
            }

        }

    }
}