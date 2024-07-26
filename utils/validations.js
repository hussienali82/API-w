const Joi = require('@hapi/joi')

//login validation
const loginUser = data => {
    const loginValidation = {  
        username: Joi.required(),
        password: Joi.required(),
    }
    return Joi.validate(data, loginValidation);
}

//add user validation
const addUser = data => {
    const userValidation = {
        usr_name: Joi.required(),
        usr_username: Joi.required(),
        usr_type: Joi.required(),
        usr_roles: Joi.required(),
        // usr_pwd: Joi.string().min(8).required(),
        usr_active: Joi.required(),
        id_org: Joi.required()
    }
    return Joi.validate(data, userValidation);
}

//edit user validation
const editUser = data => {
    const userValidation = {
        usr_name: Joi.required(),
        usr_username: Joi.required(),
        usr_roles: Joi.required(),
        usr_active: Joi.required(),
        id_org: Joi.required()
    }
    return Joi.validate(data, userValidation);
}

//reset password validation
const resetPwd = data => {
    const pwdValidation = {
        password: Joi.required()
    }
    return Joi.validate(data, pwdValidation);
}

//reset password validation
const changePwd = data => {
    const pwdValidation = {
        password: Joi.required(),
        newPassowrd: Joi.required()
    }
    return Joi.validate(data, pwdValidation);
}

//DaialyNo validation
const dailyNo = data => {
    const dailyNoValidation = {
        id_finance_year: Joi.required(),
        id_selected_org: Joi.required()
    }
    return Joi.validate(data, dailyNoValidation);
}

//DaialyNo validation
const selectedOrg = data => {
    const selectedOrgValidation = {
        id_select_fin: Joi.required(),
        id_finLink: Joi.required()
    }
    return Joi.validate(data, selectedOrgValidation);
}

//add edit TransactionType validation
const addeditTransactionType = data => {
    const TransactionTypeValidation = {
        tratypName: Joi.required(),
        tratypOp: Joi.required()
    }
    return Joi.validate(data, TransactionTypeValidation);
}

//add edit Transaction validation
const addTransaction = data => {
    const TransactionValidation = {
        traOrgId: Joi.required(),
        traTabId: Joi.required(),
        traTypId: Joi.required(),
        traAmount: Joi.required(),
        id_year: Joi.required()
    }
    return Joi.validate(data, TransactionValidation);
}

//add edit Transaction validation
const editTransaction = data => {
    const TransactionValidation = {
        traTabId: Joi.required(),
        traTypId: Joi.required(),
        traAmount: Joi.required(),
    }
    return Joi.validate(data, TransactionValidation);
}

//audit Transaction validation
const auditTransaction = data => {
    const TransactionValidation = {
        tra_audit: Joi.required(),
    }
    return Joi.validate(data, TransactionValidation);
}

//add edit BudgetAmountYearly validation
const addeditBudgetAmountYearly = data => {
    const BudgetAmountYearlyValidation = {
        id_fin_year: Joi.required(),
        id_fin_link: Joi.required(),
        tab: Joi.required()
    }
    return Joi.validate(data, BudgetAmountYearlyValidation);
}

// audit BudgetReservation validation
const auditBudgetAmountYearly = data => {
    const BudgetReservationValidation = {
        budget_audit: Joi.required(),
    }
    return Joi.validate(data, BudgetReservationValidation);
}

//add edit BudgetReservation validation
const addEditBudgetReservation = data => {
    const BudgetReservationValidation = {
        id_budget: Joi.required(),
        res_amount: Joi.required(),
        res_date: Joi.required(),
        orgId: Joi.required(),
        res_notes: Joi.required(),
        isPaid:Joi.required()
    }
    return Joi.validate(data, BudgetReservationValidation);
}

// amount revised BudgetReservation validation
const amountBudgetReservation = data => {
    const BudgetReservationValidation = {
        amount_revised: Joi.required(),
    }
    return Joi.validate(data, BudgetReservationValidation);
}

// audit BudgetReservation validation
const auditBudgetReservation = data => {
    const BudgetReservationValidation = {
        res_audit: Joi.required(),
    }
    return Joi.validate(data, BudgetReservationValidation);
}

//add BudgetMovements validation
const addBudgetMovements = data => {
    const BudgetMovementsValidation = {
        fir_id: Joi.required(),
        sec_id: Joi.required(),
        mov_amount: Joi.required(),
        mov_book_no: Joi.required(),
        mov_book_date: Joi.required(),
        notes: Joi.required()
    }
    return Joi.validate(data, BudgetMovementsValidation);
}

//add BudgetMovements validation
const editBudgetMovements = data => {
    const BudgetMovementsValidation = {
        mov_book_no: Joi.required(),
        mov_book_date: Joi.required(),
        notes: Joi.required()
    }
    return Joi.validate(data, BudgetMovementsValidation);
}

// audit BudgetMovement validation
const auditBudgetMovement = data => {
    const BudgetMovementValidation = {
        mov_audit: Joi.required(),
    }
    return Joi.validate(data, BudgetMovementValidation);
}


//add edit validation
const addEditFinYear = data => {
    const FinYearValidation = {
        year_no: Joi.required(),
        is_closed: Joi.required(),
        close_book_no: Joi.required(),
        close_book_date: Joi.required(),
        is_budget: Joi.required(),
        notes: Joi.required()
    }
    return Joi.validate(data, FinYearValidation);
}

//add exchange_doc validation
const addEditexchange_doc = data => {
    const exchange_docValidation = {
        id: Joi.required(),
        orgID: Joi.required(),
        noBook: Joi.required(),
        noDaily: Joi.required(),
        dtDaily: Joi.required(),
        ispersonal: Joi.required(),
        nmOrganize: Joi.required(),
        noDoc: Joi.required(),
        dtDoc: Joi.required(),
        identityCard: Joi.required(),
        TaxidentityCard: Joi.required(),
        dtStoreEntry: Joi.required(),
        authorizeExchange: Joi.required(),
        recipientNM: Joi.required(),
        docSummary: Joi.required(),
        userid: Joi.required(),
        docNameID: Joi.required(),
        isFinal: Joi.required(),
        totalAmountDigit: Joi.required(),
        orderHisMoney: Joi.required(),
        isTransfer: Joi.required(),
        id_daily: Joi.required(),
        noChecks: Joi.required(),
        totalAmountWrite: Joi.required(),
        attachmentNum: Joi.required(),
        dataEntry: Joi.required()
    }
    return Joi.validate(data, exchange_docValidation);
}

const addexchange_reg = data => {
    const exchange_RegValidation = {
        id: Joi.required(),
        orgID: Joi.required(),
        noBook: Joi.required(),
        noDaily: Joi.required(),
        dtDaily: Joi.required(),
        ispersonal: Joi.required(),
        nmOrganize: Joi.required(),
        noDoc: Joi.required(),
        dtDoc: Joi.required(),
        nordoc: Joi.required(),
        rorderHisMoney: Joi.required(),
        identityCard: Joi.required(),
        TaxidentityCard: Joi.required(),
        dtStoreEntry: Joi.required(),
        authorizeExchange: Joi.required(),
        recipientNM: Joi.required(),
        docSummary: Joi.required(),
        userid: Joi.required(),
        docNameID: Joi.required(),
        isFinal: Joi.required(),
        totalAmountDigit: Joi.required(),
        orderHisMoney: Joi.required(),
        isTransfer: Joi.required(),
        id_daily: Joi.required(),
        noChecks: Joi.required(),
        totalAmountWrite: Joi.required(),
        attachmentNum: Joi.required(),
        dataEntry: Joi.required()
    }
    return Joi.validate(data, exchange_RegValidation);
}

//add exchange_doc validation
const Editexchange_doc = data => {
    const exchange_docValidation = {
        id: Joi.required(),
        orgID: Joi.required(),
        noBook: Joi.required(),
        noDaily: Joi.required(),
        dtDaily: Joi.required(),
        ispersonal: Joi.required(),
        nmOrganize: Joi.required(),
        noDoc: Joi.required(),
        dtDoc: Joi.required(),
        identityCard: Joi.required(),
        TaxidentityCard: Joi.required(),
        dtStoreEntry: Joi.required(),
        authorizeExchange: Joi.required(),
        recipientNM: Joi.required(),
        docSummary: Joi.required(),
        userid: Joi.required(),
        docNameID: Joi.required(),
        isFinal: Joi.required(),
        totalAmountDigit: Joi.required(),
        orderHisMoney: Joi.required(),
        noChecks: Joi.required(),
        totalAmountWrite: Joi.required(),
        attachmentNum: Joi.required(),
        dataEntry: Joi.required(),
        nordoc: Joi.required()
    }
    return Joi.validate(data, exchange_docValidation);
}

// audit Exchange_doc validation
const auditExchange_doc = data => {
    const Exchange_docValidation = {
        doc_audit: Joi.required(),
        docNameID: Joi.required(),
    }
    return Joi.validate(data, Exchange_docValidation);
}

//add edit validation
const addChekdetails = data => {
    const chekdetailsValidation = {
        cekNam: Joi.required(),
        checkNUM: Joi.required(),
        checkamount: Joi.required(),
        dtChecks: Joi.required(),
        // exchange_documents_id: Joi.required(),
        // id: Joi.required(),
        // isTaked: Joi.required(),
    }
    return Joi.validate(data, chekdetailsValidation);
}


//add edit validation
const addMovdetails = data => {
    const MovdetailsValidation = {
        exCopy: Joi.required(),
        exNumCopy: Joi.required(),
        exNumOriginal: Joi.required(),
        exOriginal: Joi.required(),
        exchangeDoc_id: Joi.required(),
        id: Joi.required(),
    }
    return Joi.validate(data, MovdetailsValidation);
}

//add edit validation
const addExchdetails = data => {
    const ExchdetailsValidation = {
        credit: Joi.required(),
        debit: Joi.required(),
        exchangeDoc_id: Joi.required(),
        id: Joi.required(),
        tblexpensetabs_id: Joi.required()
    }
    return Joi.validate(data, ExchdetailsValidation);
}

//sms validation
const smsValidate = data => {
    const smsValidation = {
        msg: Joi.required(),
        phone: Joi.required()
    }
    return Joi.validate(data, smsValidation);
}


//export functions --------------------------
module.exports.loginUser = loginUser
module.exports.addUser = addUser
module.exports.editUser = editUser
module.exports.resetPwd = resetPwd
module.exports.dailyNo = dailyNo
module.exports.addeditTransactionType = addeditTransactionType
module.exports.addTransaction = addTransaction
module.exports.editTransaction = editTransaction
module.exports.auditTransaction = auditTransaction
module.exports.addeditBudgetAmountYearly = addeditBudgetAmountYearly
module.exports.auditBudgetAmountYearly = auditBudgetAmountYearly
module.exports.amountBudgetReservation = amountBudgetReservation
module.exports.addEditBudgetReservation = addEditBudgetReservation
module.exports.auditBudgetReservation = auditBudgetReservation
module.exports.addBudgetMovements = addBudgetMovements
module.exports.editBudgetMovements = editBudgetMovements
module.exports.auditBudgetMovement = auditBudgetMovement
module.exports.addEditFinYear = addEditFinYear
module.exports.addEditexchange_doc = addEditexchange_doc
module.exports.addexchange_reg = addexchange_reg
module.exports.Editexchange_doc = Editexchange_doc
module.exports.auditExchange_doc = auditExchange_doc
module.exports.addChekdetails = addChekdetails
module.exports.addMovdetails = addMovdetails
module.exports.addExchdetails = addExchdetails
module.exports.selectedOrg = selectedOrg
module.exports.changePwd = changePwd
module.exports.smsValidate = smsValidate
