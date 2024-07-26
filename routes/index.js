const router = require('express').Router()
const Approval_destination = require('./approval_destination')
const login = require('./login')
const Information = require('./information')
const Transmit = require('./transmit')
const Rank = require('./rank')
const Commit = require('./commit')
const Dir = require('./dir')
const Test = require('./test')
const Hospital = require('./hospital')
const Users = require('./users')
const Governs = require('./governs')
const Commands = require('./commands')
const Stations = require('./stations')
const RepInformation = require('./repInformation')
const Hospitalmid = require('./hospitalmid')
const Time = require('./time')
const RepInforMain = require('./repInforMain')
const RepTransMain = require('./reptransmain')
const GRepInforMain = require('./gRepInforMain')


router.use('/login', login)
router.use('/Information', Information)
router.use('/Transmit', Transmit)
router.use('/Rank', Rank)
router.use('/Commit', Commit)
router.use('/Dir', Dir)
router.use('/Test', Test)
router.use('/Hospital', Hospital)
router.use('/users', Users)
router.use('/Governs', Governs)
router.use('/Commands', Commands)
router.use('/Stations', Stations)
router.use('/RepInformation', RepInformation)
router.use('/Hospitalmid', Hospitalmid)
router.use('/Time', Time)
router.use('/RepInforMain', RepInforMain)
router.use('/RepTransMain', RepTransMain)
router.use('/GRepInforMain', GRepInforMain)







module.exports = router