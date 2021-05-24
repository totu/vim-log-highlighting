" Vim syntax file
" Language:         Generic log file
" Maintainer:       MTDL9 <https://github.com/MTDL9>
" Latest Revision:  2019-11-24

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" KONE
"---------------------------------------------------------------------------
syn match Number display '\(FULL_SERVICE\|SUBSCRIBE\|onInBank\|InBank\|Cnv\|CNV C\|CNV N\|CNV\|CallMaster\|KMPStack\|KMP\|Configure\)'
syn match ErrorMsg display '\(Application main() exiting\|gcapp running\|.*TOP1.*\|.*AKAK.*\|.*HSHS.*\|.*popo.*\|.*ULIULI.*\|.*AWAW.*\|.*DEBUGGG.*\|.*prpr.*\)'
syn match Function display '\(NORMAL_PERMISSION\|RETURN_SUCCESSFUL\|ON\|client-\d\|\[ON\]\|KCECPU\|KCECMD\|KCELIO\|KCELift\|KCERiser\|KCE\|kcegc-\d\|kcegc\|UNLOCKED\|INBANK\|IN_BANK\|Added subscription\)'
syn match Comment display '\(NORMAL_PERMISSION_CANCELLED\|OUT_OF_BANK\|NOTINBANK\|NOT_IN_BANK\|FAIL\|OFFLINE\|OFF\| NOT PRESENT\| NOT \)'
syn match Type display '\(EMERGENCY_POWER_DRIVE\|BUSY\|PUBLISH\|Init\|Starting subsystems...\|Configuring subsystems...\|Initializing subsystems...\|Initialize\|AAP\|PfLock\|LockDispatcher\|Dispatcher\|Dispatch\|Parking\|Park\|ConfigMaster\|LonNodeManager\|LON_DOP\|DopCtrl\|DinController\|DOP\|DopDc\|DopManagerImpl\|DopManager\|DopEntryMode\|sendDopEntryMode\|createDopLockingState\|DopLockingState\|Dop\|SCIF\|DCSIF\|RCGIF\|LonGtwConnectionDisconnected\|LonGtw\|LONGTW\|Dma\|DMA\|DeviceManagementAgent\|LON\)'
syn match Repeat display '\(PERMISSION_CANCELLED\|Shutdown on request\|Shutdown\|Closing all sessions\|Request stop\|Stopping application\|Stopping subsystems\|postStop\|PostStop\|Stop\|stopped\|stop\|Connection refused\|Disconnected\|Erasing\|UnregisterDop\|LocalServiceDown\|Unregistering\|Removing\|disconnection\|NONE\|fpo\|FPO\|sfs\|fsm\|GCAC\|CallSequencer\|LCE\|SDP\|SdpHandler\|Sdp\|sdp\)'
syn match Debug display '\(NO_NEW_CALLS\|GcParams\|AppContextManager\|SignalingManager\|TaskExecutor\|AllocEngineImp\|AllocLibProxyImp\|AllocEngine\|AllocLib\|MasterStatusRequester\|KONE\|KRMLAB\|Group\|TrafficForecasterImp\|TrafficForecaster\|Supervisor\|drvr\|Scheduler\|NodeManagerDC\|NodeManager\|SPADE\|SpadeServer\|Spade\|spadesrv\|spade\)'
syn match WarningMsg display '\(DISCONNECT\|OEO\|Oeo\|InvasionDetector\|Invasion\|EVAC\)'
syn match Special display '\(INACTIVE\|ATS\|Ats\|link\|FailWriter\|node.d\|noded\|node\|PersistenceManager\|AvnpLayer\|AVNP\|LockingManager\|ModeManager\|CoreSubsystemManager\|SubsystemManager\|ControllerFarm\)'
syn match Identifier display '\(RETURN_PERMISSION\|SUBACK\|CONNACK\|GcSecurityHandler\|GcappArgs\|GcappContext\|SppController\|Spp\|EpsController\|LiftDevice\|lifts\|lift\|MqttDriver\|MQTT\|SFS\|Sfs\|SfsClient\|SfsHelper\|InventoryHelper\|Inventory\)'


" Operators
"---------------------------------------------------------------------------
syn match logOperator display '[;,\?\:\.\<=\>\~\/\@\&\!$\%\&\+\-\|\^(){}\*#]'
syn match logBrackets display '[\[\]]'
syn match Special display '[\(\)]'
syn match Identifier display '[\{\}]'
syn match logEmptyLines display '-\{3,}'
syn match logEmptyLines display '\*\{3,}'
syn match logEmptyLines display '=\{3,}'
syn match logEmptyLines display '- - '


" Constants
"---------------------------------------------------------------------------
syn match logNumber       '\<-\?\d\+\>'
syn match logHexNumber    '\<0[xX]\x\+\>'
syn match logHexNumber    '\<\d\x\+\>'
syn match logBinaryNumber '\<0[bB][01]\+\>'
syn match logFloatNumber  '\<\d.\d\+[eE]\?\>'

syn keyword logBoolean    TRUE FALSE True False true false
syn keyword logNull       NULL Null null

syn region logString      start=/"/ end=/"/ end=/$/ skip=/\\./
" Quoted strings, but no match on quotes like "don't", "plurals' elements"
syn region logString      start=/'\(s \|t \| \w\)\@!/ end=/'/ end=/$/ end=/s / skip=/\\./


" Dates and Times
"---------------------------------------------------------------------------
" Matches 2018-03-12T or 12/03/2018 or 12/Mar/2018
syn match logDate '\d\{2,4}[-\/]\(\d\{2}\|Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)[-\/]\d\{2,4}T\?'
" Matches 8 digit numbers at start of line starting with 20
syn match logDate '^20\d\{6}'
" Matches Fri Jan 09 or Feb 11 or Apr  3
syn match logDate '\(\(Mon\|Tue\|Wed\|Thu\|Fri\|Sat\|Sun\) \)\?\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) [0-9 ]\d'

" Matches 12:09:38 or 00:03:38.129Z or 01:32:12.102938 +0700
syn match logTime '\d\{2}:\d\{2}:\d\{2}\(\.\d\{2,6}\)\?\(\s\?[-+]\d\{2,4}\|Z\)\?\>' nextgroup=logTimeZone,logSysColumns skipwhite

" Follows logTime, matches UTC or PDT 2019 or 2019 EDT
syn match logTimeZone '[A-Z]\{2,5}\>\( \d\{4}\)\?' contained
syn match logTimeZone '\d\{4} [A-Z]\{2,5}\>' contained


" Entities
"---------------------------------------------------------------------------
syn match logUrl        'http[s]\?:\/\/[^\n|,; '"]\+'
syn match logUrl        'kone/[0-9a-zA-Z+/_]*'
syn match logDomain     /\v(^|\s)(\w|-)+(\.(\w|-)+)+\s/
syn match logUUID       '\w\{8}-\w\{4}-\w\{4}-\w\{4}-\w\{12}'
syn match logMD5        '\<[a-z0-9]\{32}\>'
syn match logIPV4       '\<\d\{1,3}\(\.\d\{1,3}\)\{3}\>'
syn match logIPV6       '\<\x\{1,4}\(:\x\{1,4}\)\{7}\>'
syn match logMacAddress '\<\x\{2}\(:\x\{2}\)\{5}'
syn match logFilePath   '\<\w:\\[^\n|,; ()'"\]{}]\+'
syn match logFilePath   '[^a-zA-Z0-9"']\@<=\/\w[^\n|,; ()'"\]{}]\+'


" Syslog Columns
"---------------------------------------------------------------------------
" Syslog hostname, program and process number columns
syn match logSysColumns '\w\(\w\|\.\|-\)\+ \(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logSysProcess contained
syn match logSysProcess '\(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logNumber,logBrackets contained


" XML Tags
"---------------------------------------------------------------------------
" Simplified matches, not accurate with the spec to avoid false positives
syn match logXmlHeader       /<?\(\w\|-\)\+\(\s\+\w\+\(="[^"]*"\|='[^']*'\)\?\)*?>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlDoctype      /<!DOCTYPE[^>]*>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlTag          /<\/\?\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(\(\n\|\s\)\+\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(="[^"]*"\|='[^']*'\)\?\)*\s*\/\?>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlAttribute    contained "\w\+=" contains=logOperator
syn match logXmlAttribute    contained "\(\n\|\s\)\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(=\)\?" contains=logXmlNamespace,logOperator
syn match logXmlNamespace    contained "\(\w\|-\)\+:" contains=logOperator
syn region logXmlComment     start=/<!--/ end=/-->/
syn match logXmlCData        /<!\[CDATA\[.*\]\]>/
syn match logXmlEntity       /\&\w\+;/


" Levels
"---------------------------------------------------------------------------
syn keyword logLevelEmergency EMERGENCY EMERG
syn keyword logLevelAlert ALERT
syn keyword logLevelCritical CRITICAL CRIT FATAL
syn keyword logLevelError ERROR ERR FAILURE SEVERE
syn keyword logLevelWarning WARNING WARN
syn keyword logLevelNotice NOTICE
syn keyword logLevelInfo INFO
syn keyword logLevelDebug DEBUG FINE Debug
syn keyword logLevelTrace TRACE FINER FINEST


" Highlight links
"---------------------------------------------------------------------------
hi def link logNumber Number
hi def link logHexNumber Number
hi def link logBinaryNumber Number
hi def link logFloatNumber Float
hi def link logBoolean Boolean
hi def link logNull Constant
hi def link logString String

hi def link logDate Identifier
hi def link logTime Function
hi def link logTimeZone Identifier

hi def link logUrl Underlined
hi def link logDomain Label
hi def link logUUID Label
hi def link logMD5 Label
hi def link logIPV4 Label
hi def link logIPV6 ErrorMsg
hi def link logMacAddress Label
hi def link logFilePath Conditional

hi def link logSysColumns Conditional
hi def link logSysProcess Include

hi def link logXmlHeader Function
hi def link logXmlDoctype Function
hi def link logXmlTag Identifier
hi def link logXmlAttribute Type
hi def link logXmlNamespace Include
hi def link logXmlComment Comment
hi def link logXmlCData String
hi def link logXmlEntity Special

hi def link logOperator Operator
hi def link logBrackets Comment
hi def link logEmptyLines Comment

hi def link logLevelEmergency ErrorMsg
hi def link logLevelAlert ErrorMsg
hi def link logLevelCritical ErrorMsg
hi def link logLevelError ErrorMsg
hi def link logLevelWarning WarningMsg
hi def link logLevelNotice Character
hi def link logLevelInfo Repeat
hi def link logLevelDebug Debug
hi def link logLevelTrace Comment



let b:current_syntax = 'log'

let &cpoptions = s:cpo_save
unlet s:cpo_save

