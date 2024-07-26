//notify message ----------------
const notifyMessage = (Success, Msg, Data, Err) => {
    const notify = {
        success: Success,
        msg: Msg,
        data: Data,
        err: Err
    }
    return notify;
}



//export function-------------
module.exports.notifyMessage = notifyMessage;