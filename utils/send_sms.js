const fetch = require('node-fetch');
const dotenv = require('dotenv');
dotenv.config();

const sendsms = async (msg, phone) => {
    const send = true;
    if (send == true) {
        let payload = {
            'msg': msg,
            'phone': `00964${phone.substring(1)}`
        }
        console.log("payload",payload);
        const url = `${process.env.SMSGATEWAY_API}:${process.env.SMSGATEWAY_PORT}/api/send`;

        const method = 'POST'
        const headers = {
            auth: `auth ${process.env.SMSGATEWAY_TOKEN}`,
            'content-type': 'application/json'
        }
        const body = JSON.stringify(payload)


        let response = await fetch(url, { method, headers, body })
        let jsonRes = await response.json()

        return jsonRes
    } else {
        return {
            "msg": "sned message turned off",
            "msgID": null,
            "success": true
        }
    }
}


module.exports = { sendsms }