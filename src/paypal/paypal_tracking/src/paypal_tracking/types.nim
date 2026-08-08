import std/[options, json]

type
  BatchTrackerCollection* = ref object of RootObj
    ## The add tracking information for multiple PayPal transactions response details.
    tracker_identifiers*: Option[TrackerIdentifierList]
    errors*: Option[ErrorList]
    links*: Option[BatchTrackerCollectionDefinitionsLinkDescriptionList]

  BatchTrackerCollectionDefinitionsLinkDescriptionList* = seq[LinkDescription]

  Carrier* = enum
    ## The carrier for the shipment. Carrier information is required when
    ## tracking_number is provided. Some carriers have a global version as well as
    ## local subsidiaries. The subsidiaries are repeated over many countries and might
    ## also have an entry in the global list. Choose the carrier for your country. If
    ## the carrier is not available for your country, choose the global version of the
    ## carrier. If your carrier name is not in the list, set `carrier` to `OTHER` and
    ## set carrier name in `carrier_name_other`. For allowed values, see <a
    ## href="/docs/tracking/reference/carriers/">Carriers</a>.
    f2EBOX = "2EBOX"
    f360LION = "360LION"
    f3JMSLOGISTICS = "3JMSLOGISTICS"
    f472 = "4_72"
    f6LS = "6LS"
    A1POST = "A1POST"
    AAACOOPER = "AAA_COOPER"
    ABCUSTOM = "ABCUSTOM"
    ABXEXPRESSMY = "ABXEXPRESS_MY"
    ACOMMMERCE = "ACOMMMERCE"
    ACSWORLDWIDE = "ACSWORLDWIDE"
    ACSGR = "ACS_GR"
    ADERONLINE = "ADERONLINE"
    ADICIONAL = "ADICIONAL"
    ADSONE = "ADSONE"
    ADUIEPYLE = "ADUIEPYLE"
    AERONET = "AERONET"
    AEX = "AEX"
    AFLLOGFTP = "AFLLOG_FTP"
    AGILITY = "AGILITY"
    AIRMEEWEBHOOK = "AIRMEE_WEBHOOK"
    AIRCANADAGLOBAL = "AIR_CANADA_GLOBAL"
    ALFATREX = "ALFATREX"
    ALLIEDEXPRESS = "ALLIEDEXPRESS"
    ALLJOY = "ALLJOY"
    ALPHAFAST = "ALPHAFAST"
    ALWAYSEXPRESS = "ALWAYS_EXPRESS"
    AMAZON = "AMAZON"
    AMAZONFBASWISHIP = "AMAZON_FBA_SWISHIP"
    AMAZONSHIPMCF = "AMAZON_SHIP_MCF"
    AMSTAN = "AMSTAN"
    AMSGRP = "AMS_GRP"
    ANDREANI = "ANDREANI"
    ANICAMBOX = "ANICAM_BOX"
    ANJUN = "ANJUN"
    ANSERX = "ANSERX"
    ANPOST = "AN_POST"
    AOCOURIER = "AO_COURIER"
    AODEUTSCHLAND = "AO_DEUTSCHLAND"
    APCOVERNIGHT = "APC_OVERNIGHT"
    APCOVERNIGHTCONNUM = "APC_OVERNIGHT_CONNUM"
    APG = "APG"
    APRISAEXPRESS = "APRISAEXPRESS"
    AQUILINE = "AQUILINE"
    ARAMEX = "ARAMEX"
    ARAMEXAU = "ARAMEX_AU"
    ARCOSPEDIZIONI = "ARCO_SPEDIZIONI"
    AREEMIRATESPOST = "ARE_EMIRATES_POST"
    ARGOCA = "ARG_OCA"
    ARKLOGISTICS = "ARK_LOGISTICS"
    ASE = "ASE"
    ASENDIAHK = "ASENDIA_HK"
    ASENDIAUK = "ASENDIA_UK"
    ASENDIAUSA = "ASENDIA_USA"
    ASIGNA = "ASIGNA"
    AUPOSTCN = "AUPOST_CN"
    AUSTRIANPOSTEXPRESS = "AUSTRIAN_POST_EXPRESS"
    AUSSTARTRACK = "AUS_STARTRACK"
    AUSTOLL = "AUS_TOLL"
    AUAUSTRIANPOST = "AU_AUSTRIAN_POST"
    AUAUPOST = "AU_AU_POST"
    AUTNT = "AU_TNT"
    AVERITT = "AVERITT"
    BELDHL = "BEL_DHL"
    BELRS = "BEL_RS"
    BESTWAYPARCEL = "BESTWAYPARCEL"
    BEBPOST = "BE_BPOST"
    BEKIALA = "BE_KIALA"
    BGBULGARIANPOST = "BG_BULGARIAN_POST"
    BHPOSTA = "BH_POSTA"
    BHWORLDWIDE = "BH_WORLDWIDE"
    BIRDSYSTEM = "BIRDSYSTEM"
    BJSHOMEDELIVERY = "BJSHOMEDELIVERY"
    BLINKLASTMILE = "BLINKLASTMILE"
    BLRBELPOST = "BLR_BELPOST"
    BLUECARE = "BLUECARE"
    BLUESTAR = "BLUESTAR"
    BLUEX = "BLUEX"
    BNEED = "BNEED"
    BOMBINOEXP = "BOMBINOEXP"
    BOND = "BOND"
    BONDSCOURIERS = "BONDSCOURIERS"
    BORDEREXPRESS = "BORDEREXPRESS"
    BOXBERRY = "BOX_BERRY"
    BPOSTINT = "BPOST_INT"
    BRACORREIOS = "BRA_CORREIOS"
    BRING = "BRING"
    BROUWERTRANSPORT = "BROUWER_TRANSPORT"
    BRTIT = "BRT_IT"
    BRTITPARCELID = "BRT_IT_PARCELID"
    BRTITSENDERREF = "BRT_IT_SENDER_REF"
    BUDBEEWEBHOOK = "BUDBEE_WEBHOOK"
    BUYLOGIC = "BUYLOGIC"
    BTWOCEUROPE = "B_TWO_C_EUROPE"
    CAEDELIVERS = "CAE_DELIVERS"
    CAINIAO = "CAINIAO"
    CARIBOU = "CARIBOU"
    CARRIERS = "CARRIERS"
    CARRYFLAP = "CARRY_FLAP"
    CACANADAPOST = "CA_CANADA_POST"
    CACANPAR = "CA_CANPAR"
    CAGREYHOUND = "CA_GREYHOUND"
    CAPUROLATOR = "CA_PUROLATOR"
    CBLLOGISTICA = "CBL_LOGISTICA"
    CDEK = "CDEK"
    CDEKTR = "CDEK_TR"
    CELERITAS = "CELERITAS"
    CELLOSQUARE = "CELLO_SQUARE"
    CESKACZ = "CESKA_CZ"
    CEVA = "CEVA"
    CFLLOGISTICS = "CFL_LOGISTICS"
    CGSEXPRESS = "CGS_EXPRESS"
    CHAMPIONLOGISTICS = "CHAMPION_LOGISTICS"
    CHITCHATS = "CHITCHATS"
    CHOIREXP = "CHOIR_EXP"
    CHROBINSON = "CHROBINSON"
    CHRONOPOSTFR = "CHRONOPOST_FR"
    CHUKOU1 = "CHUKOU1"
    CHSWISSPOSTPRIORITY = "CH_SWISS_POST_PRIORITY"
    CITYLINKMY = "CITYLINK_MY"
    CJPACKET = "CJPACKET"
    CJCENTURY = "CJ_CENTURY"
    CJGLS = "CJ_GLS"
    CJHKINTERNATIONAL = "CJ_HK_INTERNATIONAL"
    CJINTMY = "CJ_INT_MY"
    CJKR = "CJ_KR"
    CJLOGISTICS = "CJ_LOGISTICS"
    CJTH = "CJ_TH"
    CLEVYLINKS = "CLEVY_LINKS"
    CLELOGISTICS = "CLE_LOGISTICS"
    CLOUDWISHASIA = "CLOUDWISH_ASIA"
    CNDEXPRESS = "CNDEXPRESS"
    CNEXPS = "CNEXPS"
    CNWANGTONG = "CNWANGTONG"
    CN17POST = "CN_17POST"
    CNBESTEXPRESS = "CN_BESTEXPRESS"
    CNBOXC = "CN_BOXC"
    CNCHINAPOSTEMS = "CN_CHINA_POST_EMS"
    CNDPEX = "CN_DPEX"
    CNEMS = "CN_EMS"
    CNEQUICK = "CN_EQUICK"
    CNJCEX = "CN_JCEX"
    CNPAYPALPACKAGE = "CN_PAYPAL_PACKAGE"
    CNPOST56 = "CN_POST56"
    CNSFEXPRESS = "CN_SF_EXPRESS"
    CNSTO = "CN_STO"
    CNWEDO = "CN_WEDO"
    CNWISHPOST = "CN_WISHPOST"
    CNYUNDA = "CN_YUNDA"
    COLISPRIVE = "COLIS_PRIVE"
    COLLECTCO = "COLLECTCO"
    COLLIVERY = "COLLIVERY"
    COMETTECH = "COMET_TECH"
    CONTINENTAL = "CONTINENTAL"
    CONWAY = "CON_WAY"
    COORDINADORA = "COORDINADORA"
    COPACOURIER = "COPA_COURIER"
    COPE = "COPE"
    CORPORATECOURIERSWEBHOOK = "CORPORATECOURIERS_WEBHOOK"
    CORREOSDEMEXICO = "CORREOS_DE_MEXICO"
    CORREOSES = "CORREOS_ES"
    CORREOSEXPRESS = "CORREOS_EXPRESS"
    CORREOUY = "CORREO_UY"
    COSTMETICSNOW = "COSTMETICSNOW"
    COURANTPLUS = "COURANT_PLUS"
    COUREX = "COUREX"
    COURIERSPLEASE = "COURIERS_PLEASE"
    CPACKET = "CPACKET"
    CPEX = "CPEX"
    CROSHOT = "CROSHOT"
    CSE = "CSE"
    CTCEXPRESS = "CTC_EXPRESS"
    CUBYN = "CUBYN"
    CUCKOOEXPRESS = "CUCKOOEXPRESS"
    CYPRUSPOSTCYP = "CYPRUS_POST_CYP"
    DAIGLOBALTRACK = "DAIGLOBALTRACK"
    DAJIN = "DAJIN"
    DANSKEFRAGT = "DANSKE_FRAGT"
    DAWNWING = "DAWN_WING"
    DAYTONFREIGHT = "DAYTON_FREIGHT"
    DBSCHENKERB2B = "DBSCHENKER_B2B"
    DBSCHENKERSE = "DBSCHENKER_SE"
    DBSCHENKERSV = "DBSCHENKER_SV"
    DDEXPRESS = "DDEXPRESS"
    DEALERSEND = "DEALERSEND"
    DELIVERYONTIME = "DELIVERYONTIME"
    DELNEXT = "DELNEXT"
    DELTECUK = "DELTEC_UK"
    DEMANDSHIP = "DEMANDSHIP"
    DESCARTES = "DESCARTES"
    DESIGNERTRANSPORTWEBHOOK = "DESIGNERTRANSPORT_WEBHOOK"
    DESTINY = "DESTINY"
    DEXI = "DEX_I"
    DEASENDIA = "DE_ASENDIA"
    DEDEUTSCHE = "DE_DEUTSCHE"
    DEDEUTSCHEPOSTDHLWITHINEUROPETRACKNET = "DE_DEUTSCHE_POST_DHL_WITHIN_EUROPE_TRACKNET"
    DEDHLEXPRESS = "DE_DHL_EXPRESS"
    DEDPDDELISTRACK = "DE_DPD_DELISTRACK"
    DEGLS = "DE_GLS"
    DHL = "DHL"
    DHLACTIVETRACING = "DHL_ACTIVE_TRACING"
    DHLAU = "DHL_AU"
    DHLBENELUX = "DHL_BENELUX"
    DHLECOMERCEASA = "DHL_ECOMERCE_ASA"
    DHLES = "DHL_ES"
    DHLFR = "DHL_FR"
    DHLFREIGHT = "DHL_FREIGHT"
    DHLGLOBALMAILASIA = "DHL_GLOBAL_MAIL_ASIA"
    DHLHK = "DHL_HK"
    DHLJP = "DHL_JP"
    DHLPARCELES = "DHL_PARCEL_ES"
    DHLPARCELNL = "DHL_PARCEL_NL"
    DHLPARCELRU = "DHL_PARCEL_RU"
    DHLPL = "DHL_PL"
    DHLREFR = "DHL_REFR"
    DHLSG = "DHL_SG"
    DHLSUPPLYCHAIN = "DHL_SUPPLY_CHAIN"
    DHLUK = "DHL_UK"
    DIAMONDEUROGISTICS = "DIAMOND_EUROGISTICS"
    DICOM = "DICOM"
    DIDADI = "DIDADI"
    DIMERCO = "DIMERCO"
    DIRECTCOURIERS = "DIRECTCOURIERS"
    DIRECTLOG = "DIRECTLOG"
    DIRECTPARCELS = "DIRECTPARCELS"
    DMMNETWORK = "DMM_NETWORK"
    DMSMATRIX = "DMS_MATRIX"
    DOBROPOST = "DOBROPOST"
    DOORA = "DOORA"
    DOORDASHWEBHOOK = "DOORDASH_WEBHOOK"
    DPD = "DPD"
    DPDDELISTRACK = "DPD_DELISTRACK"
    DPDFR = "DPD_FR"
    DPDHGRY = "DPD_HGRY"
    DPDHK = "DPD_HK"
    DPDIR = "DPD_IR"
    DPDLOCAL = "DPD_LOCAL"
    DPDLOCALREF = "DPD_LOCAL_REF"
    DPDPOLAND = "DPD_POLAND"
    DPDRO = "DPD_RO"
    DPDRU = "DPD_RU"
    DPEX = "DPEX"
    DPEEXPRESS = "DPE_EXPRESS"
    DPESOUTHAFRC = "DPE_SOUTH_AFRC"
    DSV = "DSV"
    DTDCAU = "DTDC_AU"
    DTDCEXPRESS = "DTDC_EXPRESS"
    DTDCIN = "DTDC_IN"
    DTDEXPR = "DTD_EXPR"
    DXSFTP = "DX_SFTP"
    DYLT = "DYLT"
    DYNALOGIC = "DYNALOGIC"
    EASYMAIL = "EASY_MAIL"
    ECEXPRESS = "ECEXPRESS"
    ECHO = "ECHO"
    ECMS = "ECMS"
    ECOSCOOTING = "ECOSCOOTING"
    EFEX = "EFEX"
    EFS = "EFS"
    EKART = "EKART"
    ELIANPOST = "ELIAN_POST"
    EMPSCN = "EMPS_CN"
    ENDEAVOURDELIVERY = "ENDEAVOUR_DELIVERY"
    ENVIALIAREFERENCE = "ENVIALIA_REFERENCE"
    EPARCELKR = "EPARCEL_KR"
    EPSTGLBL = "EPST_GLBL"
    EPBOX = "EP_BOX"
    ESHIPPING = "ESHIPPING"
    ESPASM = "ESP_ASM"
    ESPENVIALIA = "ESP_ENVIALIA"
    ESPMRW = "ESP_MRW"
    ESPNACEX = "ESP_NACEX"
    ESPPACKLINK = "ESP_PACKLINK"
    ESPREDUR = "ESP_REDUR"
    ETOMARS = "ETOMARS"
    ETOTAL = "ETOTAL"
    ETSEXPRESS = "ETS_EXPRESS"
    EUFLEETSOLUTIONS = "EU_FLEET_SOLUTIONS"
    EUIMX = "EU_IMX"
    EXPRESSSALE = "EXPRESSSALE"
    FARGOOD = "FARGOOD"
    FARINTERNATIONAL = "FAR_INTERNATIONAL"
    FASTRACK = "FASTRACK"
    FASTRKSERV = "FASTRK_SERV"
    FASTWAYIR = "FASTWAY_IR"
    FASTWAYNZ = "FASTWAY_NZ"
    FDSEXPRESS = "FDSEXPRESS"
    FEDEX = "FEDEX"
    FEDEXCROSSBORDER = "FEDEX_CROSSBORDER"
    FEDEXFR = "FEDEX_FR"
    FEDEXINTLMLSERV = "FEDEX_INTL_MLSERV"
    FEDEXPOLAND = "FEDEX_POLAND"
    FEDEXUK = "FEDEX_UK"
    FETCHRWEBHOOK = "FETCHR_WEBHOOK"
    FIEGE = "FIEGE"
    FIEGENL = "FIEGE_NL"
    FIRSTMILE = "FIRSTMILE"
    FLASHEXPRESS = "FLASHEXPRESS"
    FMX = "FMX"
    FONSEN = "FONSEN"
    FORRUN = "FORRUN"
    FREIGHTQUOTE = "FREIGHTQUOTE"
    FRETERAPIDO = "FRETERAPIDO"
    FRBERT = "FR_BERT"
    FRCOLIS = "FR_COLIS"
    FREXAPAQ = "FR_EXAPAQ"
    FRGEODIS = "FR_GEODIS"
    FRGLS = "FR_GLS"
    FULFILLA = "FULFILLA"
    FULFILLME = "FULFILLME"
    FURDECO = "FURDECO"
    GAC = "GAC"
    GANGBAO = "GANGBAO"
    GBA = "GBA"
    GBSBROKER = "GBS_BROKER"
    GBAPC = "GB_APC"
    GBARROW = "GB_ARROW"
    GBNORSK = "GB_NORSK"
    GBPANTHER = "GB_PANTHER"
    GBTUFFNELLS = "GB_TUFFNELLS"
    GEIS = "GEIS"
    GELEXPRESS = "GEL_EXPRESS"
    GEMWORLDWIDE = "GEMWORLDWIDE"
    GENERALOVERNIGHT = "GENERAL_OVERNIGHT"
    GENIKIGR = "GENIKI_GR"
    GEODISESPACE = "GEODIS_ESPACE"
    GESWL = "GESWL"
    GIAOHANG = "GIAO_HANG"
    GIOEXPRESS = "GIO_EXPRESS"
    GLOBALTRANZ = "GLOBALTRANZ"
    GLOBALABF = "GLOBAL_ABF"
    GLOBALESTES = "GLOBAL_ESTES"
    GLOBALEXPRESS = "GLOBAL_EXPRESS"
    GLOBALIPARCEL = "GLOBAL_IPARCEL"
    GLOBALTNT = "GLOBAL_TNT"
    GLOBAVEND = "GLOBAVEND"
    GLSCROTIA = "GLS_CROTIA"
    GLSCZ = "GLS_CZ"
    GLSIT = "GLS_IT"
    GLSITALY = "GLS_ITALY"
    GLSSLOV = "GLS_SLOV"
    GLSSLOVEN = "GLS_SLOVEN"
    GOGLOBALPOST = "GOGLOBALPOST"
    GOJEK = "GOJEK"
    GRABWEBHOOK = "GRAB_WEBHOOK"
    GRUPO = "GRUPO"
    GRELTA = "GR_ELTA"
    GSIEXPRESS = "GSI_EXPRESS"
    GSO = "GSO"
    HAPPY2POINT = "HAPPY2POINT"
    HCTLOGISTICS = "HCT_LOGISTICS"
    HDB = "HDB"
    HDBBOX = "HDB_BOX"
    HELLMANN = "HELLMANN"
    HELTHJEM = "HELTHJEM"
    HEPPNER = "HEPPNER"
    HEPPNERFR = "HEPPNER_FR"
    HERMES = "HERMES"
    HERMES2MANNHANDLING = "HERMES_2MANN_HANDLING"
    HERMESDE = "HERMES_DE"
    HHEXP = "HH_EXP"
    HIPSHIPPER = "HIPSHIPPER"
    HKD = "HKD"
    HKFLYTEXPRESS = "HK_FLYT_EXPRESS"
    HKFOURPXEXPRESS = "HK_FOUR_PX_EXPRESS"
    HKPOST = "HK_POST"
    HKTGX = "HK_TGX"
    HOLISOL = "HOLISOL"
    HOMEDELIVERYSOLUTIONS = "HOME_DELIVERY_SOLUTIONS"
    HOUNDEXPRESS = "HOUNDEXPRESS"
    HRPARCEL = "HRPARCEL"
    HRVHRVATSKA = "HRV_HRVATSKA"
    HUAHANEXPRESS = "HUAHAN_EXPRESS"
    HUNTEREXPRESS = "HUNTER_EXPRESS"
    HUODULL = "HUODULL"
    HXEXPRESS = "HX_EXPRESS"
    IBEONE = "IBEONE"
    ICUMULUS = "ICUMULUS"
    IDEXPRESS = "IDEXPRESS"
    IDNJNE = "IDN_JNE"
    IDNLIONPARCEL = "IDN_LION_PARCEL"
    IDNPANDU = "IDN_PANDU"
    IML = "IML"
    INDOPAKET = "INDOPAKET"
    INDBLUEDART = "IND_BLUEDART"
    INDDELHIVERY = "IND_DELHIVERY"
    INDDELIVREE = "IND_DELIVREE"
    INDDOTZOT = "IND_DOTZOT"
    INDECOM = "IND_ECOM"
    INDFIRSTFLIGHT = "IND_FIRSTFLIGHT"
    INDGATI = "IND_GATI"
    INDGOJAVAS = "IND_GOJAVAS"
    INDPROFESSIONALCOURIERS = "IND_PROFESSIONAL_COURIERS"
    INDSAFEEXPRESS = "IND_SAFEEXPRESS"
    INDXPRESSBEES = "IND_XPRESSBEES"
    INPOSTPACZKOMATY = "INPOST_PACZKOMATY"
    INTEGRA2FTP = "INTEGRA2_FTP"
    INTELIPOST = "INTELIPOST"
    INTELVALLEY = "INTEL_VALLEY"
    INTERPARCELAU = "INTERPARCEL_AU"
    INTERPARCELNZ = "INTERPARCEL_NZ"
    INTERPARCELUK = "INTERPARCEL_UK"
    INTEXPRESS = "INTEXPRESS"
    ISRAELPOST = "ISRAEL_POST"
    ISRPOSTDOMESTIC = "ISR_POST_DOMESTIC"
    ITDHLECOMMERCE = "IT_DHL_ECOMMERCE"
    ITFERCAM = "IT_FERCAM"
    ITNEXIVE = "IT_NEXIVE"
    ITPOSTEITALIA = "IT_POSTE_ITALIA"
    ITTNT = "IT_TNT"
    IVOYWEBHOOK = "IVOY_WEBHOOK"
    IDIKA = "I_DIKA"
    JANCO = "JANCO"
    JANIO = "JANIO"
    JERSEYPOST = "JERSEY_POST"
    JETSHIP = "JET_SHIP"
    JINDOUYUN = "JINDOUYUN"
    JINSUNG = "JINSUNG"
    JOCOM = "JOCOM"
    JOOMLOGIS = "JOOM_LOGIS"
    JOYINGBOX = "JOYING_BOX"
    JPNJAPANPOST = "JPN_JAPAN_POST"
    JPNSAGAWA = "JPN_SAGAWA"
    JPKURONEKOYAMATOUNYUU = "JP_KURO_NEKO_YAMATO_UNYUU"
    JSEXPRESS = "JS_EXPRESS"
    JTEXPRESS = "JTEXPRESS"
    JTEXPRESSVN = "JTEXPRESS_VN"
    JX = "JX"
    JNET = "J_NET"
    K1EXPRESS = "K1_EXPRESS"
    KANGAROOMY = "KANGAROO_MY"
    KEC = "KEC"
    KERRYTJ = "KERRYTJ"
    KERRYTTCVN = "KERRYTTC_VN"
    KERRYECOMMERCE = "KERRY_ECOMMERCE"
    KGMHUB = "KGMHUB"
    KHMCAMBODIAPOST = "KHM_CAMBODIA_POST"
    KORECARGO = "KOR_ECARGO"
    KPOST = "KPOST"
    KRKOREAPOST = "KR_KOREA_POST"
    KUEHNE = "KUEHNE"
    KURASI = "KURASI"
    KWEGLOBAL = "KWE_GLOBAL"
    KWT = "KWT"
    KYUNGDONGPARCEL = "KYUNGDONG_PARCEL"
    KYEXPRESS = "KY_EXPRESS"
    LALAMOVE = "LALAMOVE"
    LANDMARKGLOBAL = "LANDMARK_GLOBAL"
    LANDMARKGLOBALREFERENCE = "LANDMARK_GLOBAL_REFERENCE"
    LATVIJASPASTS = "LATVIJAS_PASTS"
    LAPOSTESUIVI = "LA_POSTE_SUIVI"
    LBCEXPRESSFTP = "LBCEXPRESS_FTP"
    LEADER = "LEADER"
    LEGIONEXPRESS = "LEGION_EXPRESS"
    LEXSHIP = "LEXSHIP"
    LHTEXPRESS = "LHT_EXPRESS"
    LICCARDIEXPRESS = "LICCARDI_EXPRESS"
    LIEFERY = "LIEFERY"
    LINE = "LINE"
    LINKBRIDGE = "LINKBRIDGE"
    LOCUSWEBHOOK = "LOCUS_WEBHOOK"
    LOGISTERS = "LOGISTERS"
    LOGISTICSWORLDWIDEHK = "LOGISTICSWORLDWIDE_HK"
    LOGISTIKA = "LOGISTIKA"
    LOGISTYXTRANSGROUP = "LOGISTYX_TRANSGROUP"
    LONESTAR = "LONESTAR"
    LOOMISEXPRESS = "LOOMIS_EXPRESS"
    LOTTE = "LOTTE"
    LTIANEXP = "LTIANEXP"
    LTL = "LTL"
    LTULIETUVOS = "LTU_LIETUVOS"
    MAGYARHU = "MAGYAR_HU"
    MAILAMERICAS = "MAILAMERICAS"
    MAILPLUSJPN = "MAILPLUS_JPN"
    MAILPLUS = "MAIL_PLUS"
    MAINFREIGHT = "MAINFREIGHT"
    MAINWAY = "MAINWAY"
    MATDESPATCH = "MATDESPATCH"
    MATKAHUOLTO = "MATKAHUOLTO"
    MBW = "MBW"
    MEXAEROFLASH = "MEX_AEROFLASH"
    MEXESTAFETA = "MEX_ESTAFETA"
    MEXREDPACK = "MEX_REDPACK"
    MEXSENDA = "MEX_SENDA"
    MGLOBAL = "MGLOBAL"
    MIKROPAKKET = "MIKROPAKKET"
    MIKROPAKKETBE = "MIKROPAKKET_BE"
    MILKMAN = "MILKMAN"
    MORELINK = "MORE_LINK"
    MORNINGEXPRESS = "MORNING_EXPRESS"
    MRWFTP = "MRW_FTP"
    MXE = "MXE"
    MXCARGO = "MX_CARGO"
    MYHERMES = "MYHERMES"
    MYSAIRPAK = "MYS_AIRPAK"
    MYSEMS = "MYS_EMS"
    MYSGDEX = "MYS_GDEX"
    MYSMYPOSTONLINE = "MYS_MYPOST_ONLINE"
    MYSMYSPOST = "MYS_MYS_POST"
    MYSSKYNET = "MYS_SKYNET"
    MXPRESS = "M_XPRESS"
    NACEX = "NACEX"
    NACEXES = "NACEX_ES"
    NANJINGWOYUAN = "NANJINGWOYUAN"
    NATIONALSAMEDAY = "NATIONAL_SAMEDAY"
    NATIONEX = "NATIONEX"
    NATIONWIDEMY = "NATIONWIDE_MY"
    NEWAY = "NEWAY"
    NEWEGGEXPRESS = "NEWEGGEXPRESS"
    NEWGISTICS = "NEWGISTICS"
    NEWZEALANDCOURIERS = "NEWZEALAND_COURIERS"
    NGCOURIERPLUS = "NG_COURIERPLUS"
    NHANSSOLUTIONS = "NHANS_SOLUTIONS"
    NIMEXPRESS = "NIM_EXPRESS"
    NINJAVANMY = "NINJAVAN_MY"
    NINJAVANSG = "NINJAVAN_SG"
    NINJAVANTHAI = "NINJAVAN_THAI"
    NINJAVANWB = "NINJAVAN_WB"
    NIPOSTNG = "NIPOST_NG"
    NLDDHL = "NLD_DHL"
    NLDGLS = "NLD_GLS"
    NLDPOSTNL = "NLD_POSTNL"
    NLDTRANSMISSION = "NLD_TRANSMISSION"
    NOVAPOSHTA = "NOVA_POSHTA"
    NOVAPOSHTAINT = "NOVA_POSHTA_INT"
    NOXNACHTEXPRESS = "NOX_NACHTEXPRESS"
    NOXNIGHTTIMEEXPRESS = "NOX_NIGHT_TIME_EXPRESS"
    NTLOGISTICSVN = "NTLOGISTICS_VN"
    NZCOURIERPOST = "NZ_COURIER_POST"
    NZNZPOST = "NZ_NZ_POST"
    OCS = "OCS"
    OCSWORLDWIDE = "OCS_WORLDWIDE"
    OKAYPARCEL = "OKAYPARCEL"
    OMNIPARCEL = "OMNIPARCEL"
    OMNIVA = "OMNIVA"
    ONECLICK = "ONECLICK"
    ONEWORLDEXPRESS = "ONEWORLDEXPRESS"
    ORANGEDS = "ORANGE_DS"
    OSMWORLDWIDE = "OSM_WORLDWIDE"
    OVERSEEXP = "OVERSE_EXP"
    P2PTRC = "P2P_TRC"
    PAACKWEBHOOK = "PAACK_WEBHOOK"
    PADTF = "PADTF"
    PAGO = "PAGO"
    PALEXPRESS = "PALEXPRESS"
    PALLETWAYS = "PALLETWAYS"
    PALLETNETWORK = "PALLET_NETWORK"
    PANTHERREFERENCE = "PANTHER_REFERENCE"
    PANASIA = "PAN_ASIA"
    PAPERFLY = "PAPERFLY"
    PAPEREXPRESS = "PAPER_EXPRESS"
    PAQUETEXPRESS = "PAQUETEXPRESS"
    PARCEL2GO = "PARCEL2GO"
    PARCELINKLOGISTICS = "PARCELINKLOGISTICS"
    PARCELLEDIN = "PARCELLED_IN"
    PARCELONE = "PARCELONE"
    PARCELPALWEBHOOK = "PARCELPAL_WEBHOOK"
    PARCELPOINT = "PARCELPOINT"
    PARCELPOSTSG = "PARCELPOST_SG"
    PARCEL2POST = "PARCEL_2_POST"
    PARKNPARCEL = "PARKNPARCEL"
    PCFCORP = "PCFCORP"
    PFCEXPRESS = "PFCEXPRESS"
    PFLOGISTICS = "PFLOGISTICS"
    PHLAIR21 = "PHL_AIR21"
    PHLAIRSPEED = "PHL_AIRSPEED"
    PHLJAMEXPRESS = "PHL_JAMEXPRESS"
    PICKRR = "PICKRR"
    PICKUP = "PICKUP"
    PICKUPPMYS = "PICKUPP_MYS"
    PICKUPPSGP = "PICKUPP_SGP"
    PILOTFREIGHT = "PILOT_FREIGHT"
    PILLOGISTICS = "PIL_LOGISTICS"
    PITNEYBOWES = "PITNEY_BOWES"
    PITTOHIO = "PITTOHIO"
    PIXSELL = "PIXSELL"
    PLANZER = "PLANZER"
    PLUSLOGUK = "PLUS_LOG_UK"
    PLPOCZTAPOLSKA = "PL_POCZTA_POLSKA"
    POLSIODEMKA = "POL_SIODEMKA"
    PONYEXPRESS = "PONY_EXPRESS"
    POSTAPLUS = "POSTA_PLUS"
    POSTARO = "POSTA_RO"
    POSTAUKR = "POSTA_UKR"
    POSTENNORGE = "POSTEN_NORGE"
    POSTI = "POSTI"
    POSTNLINTL3S = "POSTNL_INTL_3S"
    POSTNLINT3S = "POSTNL_INT_3_S"
    POSTNORDLOGISTICS = "POSTNORD_LOGISTICS"
    POSTNORDLOGISTICSDK = "POSTNORD_LOGISTICS_DK"
    POSTURIS = "POSTUR_IS"
    POSTSERBIA = "POST_SERBIA"
    POSTSLOVENIA = "POST_SLOVENIA"
    PRESIDENTTRANS = "PRESIDENT_TRANS"
    PRESSIODE = "PRESSIODE"
    PRIMAMULTICIPTA = "PRIMAMULTICIPTA"
    PROMEDDELIVERY = "PROMEDDELIVERY"
    PRTCHRONOPOST = "PRT_CHRONOPOST"
    PRTCTT = "PRT_CTT"
    PRTINTSEUR = "PRT_INT_SEUR"
    PRTSEUR = "PRT_SEUR"
    PTS = "PTS"
    PTTPOST = "PTT_POST"
    QUANTIUM = "QUANTIUM"
    QWINTRY = "QWINTRY"
    RABENGROUP = "RABEN_GROUP"
    RAFPH = "RAF_PH"
    RAIDEREX = "RAIDEREX"
    RAM = "RAM"
    RCL = "RCL"
    RINCOS = "RINCOS"
    RLUS = "RL_US"
    ROADBULL = "ROADBULL"
    ROADRUNNERFREIGHT = "ROADRUNNER_FREIGHT"
    ROCKETPARCEL = "ROCKET_PARCEL"
    ROUTIFICWEBHOOK = "ROUTIFIC_WEBHOOK"
    ROYALMAIL = "ROYAL_MAIL"
    RPD2MAN = "RPD2MAN"
    RPX = "RPX"
    RPXLOGISTICS = "RPXLOGISTICS"
    RPXID = "RPX_ID"
    RUSSIANPOST = "RUSSIAN_POST"
    RUSTON = "RUSTON"
    RZYEXPRESS = "RZYEXPRESS"
    SAIAFREIGHT = "SAIA_FREIGHT"
    SAILPOST = "SAILPOST"
    SAPEXPRESS = "SAP_EXPRESS"
    SAUSAUDIPOST = "SAU_SAUDI_POST"
    SCUDEXEXPRESS = "SCUDEX_EXPRESS"
    SDAIT = "SDA_IT"
    SDHSCM = "SDH_SCM"
    SEFL = "SEFL"
    SEINO = "SEINO"
    SEKOLOGISTICS = "SEKOLOGISTICS"
    SEKOSFTP = "SEKO_SFTP"
    SENDING = "SENDING"
    SENDIT = "SENDIT"
    SENDLE = "SENDLE"
    SEURES = "SEUR_ES"
    SEURSPAPI = "SEUR_SP_API"
    SFB2C = "SFB2C"
    SFCSERVICE = "SFCSERVICE"
    SFCLOGISTICS = "SFC_LOGISTICS"
    SFPLUSWEBHOOK = "SFPLUS_WEBHOOK"
    SFEX = "SF_EX"
    SGDETRACK = "SG_DETRACK"
    SGQXPRESS = "SG_QXPRESS"
    SGSGPOST = "SG_SG_POST"
    SGSPEEDPOST = "SG_SPEEDPOST"
    SGTAQBIN = "SG_TAQBIN"
    SHENZHEN = "SHENZHEN"
    SHIPENTEGRA = "SHIPENTEGRA"
    SHIPPIT = "SHIPPIT"
    SHIPTER = "SHIPTER"
    SHIPTOR = "SHIPTOR"
    SHIPGATE = "SHIP_GATE"
    SHIPITASIA = "SHIP_IT_ASIA"
    SHOPFANS = "SHOPFANS"
    SHREENANDANCOURIER = "SHREENANDANCOURIER"
    SHREETIRUPATI = "SHREETIRUPATI"
    SHREEANJANICOURIER = "SHREE_ANJANI_COURIER"
    SHREEMARUTI = "SHREE_MARUTI"
    SIMPLYPOST = "SIMPLYPOST"
    SINOTRANS = "SINOTRANS"
    SINGLBL = "SIN_GLBL"
    SKYBOX = "SKYBOX"
    SKYNETUAE = "SKYNET_UAE"
    SKYNETUK = "SKYNET_UK"
    SKYNETWORLDWIDE = "SKYNET_WORLDWIDE"
    SKYNETZA = "SKYNET_ZA"
    SKYPOSTAL = "SKY_POSTAL"
    SKPOSTA = "SK_POSTA"
    SMGEXPRESS = "SMG_EXPRESS"
    SMOOTH = "SMOOTH"
    SMSAEXPRESS = "SMSA_EXPRESS"
    SONICTL = "SONICTL"
    SOUTHAFRICANPOSTOFFICE = "SOUTH_AFRICAN_POST_OFFICE"
    SPEEDCOURIERSGR = "SPEEDCOURIERS_GR"
    SPEEDEE = "SPEEDEE"
    SPEEDEXCOURIER = "SPEEDEXCOURIER"
    SPOTON = "SPOTON"
    SPRINGGDS = "SPRING_GDS"
    SREKOREA = "SRE_KOREA"
    STALLIONEXPRESS = "STALLIONEXPRESS"
    STARKEN = "STARKEN"
    STARTRACKEXPRESS = "STAR_TRACK_EXPRESS"
    STARTRACKNEXTFLIGHT = "STAR_TRACK_NEXT_FLIGHT"
    STEPFORWARDFS = "STEPFORWARDFS"
    STONE3PL = "STONE3PL"
    STRECKTRANSPORT = "STRECK_TRANSPORT"
    SUTTON = "SUTTON"
    SWEPOSTNORD = "SWE_POSTNORD"
    SWISHIPDE = "SWISHIP_DE"
    SWISSPOSTFTP = "SWISS_POST_FTP"
    SYPOST = "SYPOST"
    SZENDEX = "SZENDEX"
    TAQBINHK = "TAQBIN_HK"
    TAQBINMY = "TAQBIN_MY"
    TARRIVE = "TARRIVE"
    TAZMANIANFREIGHT = "TAZMANIAN_FREIGHT"
    TCKEXPRESS = "TCK_EXPRESS"
    TCS = "TCS"
    TFM = "TFM"
    TFORCEFINALMILE = "TFORCE_FINALMILE"
    THABITLOGISTICS = "THABIT_LOGISTICS"
    THADYNAMICLOGISTICS = "THA_DYNAMIC_LOGISTICS"
    THAKERRY = "THA_KERRY"
    THATHAILANDPOST = "THA_THAILAND_POST"
    THECOURIERGUY = "THECOURIERGUY"
    THEDELIVERYGROUP = "THEDELIVERYGROUP"
    THENILEWEBHOOK = "THENILE_WEBHOOK"
    TIGFREIGHT = "TIGFREIGHT"
    TIKIID = "TIKI_ID"
    TIPSA = "TIPSA"
    TNT = "TNT"
    TNTCLICKIT = "TNT_CLICK_IT"
    TNTFR = "TNT_FR"
    TNTNL = "TNT_NL"
    TNTREFR = "TNT_REFR"
    TNTUK = "TNT_UK"
    TNTUKREFR = "TNT_UK_REFR"
    TOLL = "TOLL"
    TOLLNZ = "TOLL_NZ"
    TOLOS = "TOLOS"
    TOPHATTEREXPRESS = "TOPHATTEREXPRESS"
    TOPYOU = "TOPYOU"
    TOTALEXPRESS = "TOTAL_EXPRESS"
    TOURLINE = "TOURLINE"
    TRACKON = "TRACKON"
    TRANSKARGO = "TRANS_KARGO"
    TRUMPCARD = "TRUMPCARD"
    TRUNKRSWEBHOOK = "TRUNKRS_WEBHOOK"
    TUFFNELLSREFERENCE = "TUFFNELLS_REFERENCE"
    TWOGO = "TWO_GO"
    TWTAIWANPOST = "TW_TAIWAN_POST"
    UBILOGISTICS = "UBI_LOGISTICS"
    UCEXPRE = "UC_EXPRE"
    UDS = "UDS"
    UKCOLLECTPLUS = "UK_COLLECTPLUS"
    UKDPD = "UK_DPD"
    UKNIGHTLINE = "UK_NIGHTLINE"
    UKPARCELFORCE = "UK_PARCELFORCE"
    UKUKMAIL = "UK_UK_MAIL"
    UKXDP = "UK_XDP"
    UKYODEL = "UK_YODEL"
    UPS = "UPS"
    UPSFREIGHT = "UPS_FREIGHT"
    UPSMAILINNOVATIONS = "UPS_MAIL_INNOVATIONS"
    UPSREFERENCE = "UPS_REFERENCE"
    USFREDDAWAY = "USF_REDDAWAY"
    USHIP = "USHIP"
    USPS = "USPS"
    USGLOBEGISTICS = "US_GLOBEGISTICS"
    USLASERSHIP = "US_LASERSHIP"
    USOLDDOMINION = "US_OLD_DOMINION"
    USONTRAC = "US_ONTRAC"
    USYRC = "US_YRC"
    VAMOX = "VAMOX"
    VENIPAK = "VENIPAK"
    VIAEUROPE = "VIAEUROPE"
    VIAEXPRESS = "VIA_EXPRESS"
    VIRTRANSPORT = "VIRTRANSPORT"
    VIWO = "VIWO"
    VNMVIETNAMPOST = "VNM_VIETNAM_POST"
    VNMVIETTELPOST = "VNM_VIETTELPOST"
    WAHANAID = "WAHANA_ID"
    WANBEXPRESS = "WANBEXPRESS"
    WEASHIP = "WEASHIP"
    WEPOST = "WEPOST"
    WESTBANKCOURIER = "WESTBANK_COURIER"
    WESTGATEGL = "WESTGATE_GL"
    WHISTL = "WHISTL"
    WINIT = "WINIT"
    WISELOADS = "WISELOADS"
    WISEEXPRESS = "WISE_EXPRESS"
    WIZMO = "WIZMO"
    WMG = "WMG"
    WNDIRECT = "WNDIRECT"
    WYNGS = "WYNGS"
    XDEWEBHOOK = "XDE_WEBHOOK"
    XDPUKREFERENCE = "XDP_UK_REFERENCE"
    XLEXPRESS = "XL_EXPRESS"
    XPERTDELIVERY = "XPERT_DELIVERY"
    XPOST = "XPOST"
    XPOLOGISTICS = "XPO_LOGISTICS"
    XPRESSENDK = "XPRESSEN_DK"
    XQEXPRESS = "XQ_EXPRESS"
    YAKIT = "YAKIT"
    YANWEN = "YANWEN"
    YDHEXPRESS = "YDH_EXPRESS"
    YINGNUOLOGISTICS = "YINGNUO_LOGISTICS"
    YODELDIR = "YODEL_DIR"
    YODELINTNL = "YODEL_INTNL"
    YTO = "YTO"
    YUNEXPRESS = "YUNEXPRESS"
    YURTICIKARGO = "YURTICI_KARGO"
    YUSEN = "YUSEN"
    ZAJILEXPRESS = "ZAJIL_EXPRESS"
    ZACOURIERIT = "ZA_COURIERIT"
    ZAFASTWAY = "ZA_FASTWAY"
    ZASPECIALISEDFREIGHT = "ZA_SPECIALISED_FREIGHT"
    ZEEK2DOOR = "ZEEK_2_DOOR"
    ZELERIS = "ZELERIS"
    ZEPTOEXPRESS = "ZEPTO_EXPRESS"
    ZESEXPRESS = "ZES_EXPRESS"
    ZIINGFINALMILE = "ZIINGFINALMILE"
    ZINC = "ZINC"
    ZJSEXPRESS = "ZJS_EXPRESS"
    ZTOEXPRESS = "ZTO_EXPRESS"
    ZYLLEM = "ZYLLEM"

  DateNoTime* = string

  DateTime* = string

  DefinitionsLinkDescriptionList* = seq[LinkDescription2]

  DefinitionsTrackerIdentifierList* = seq[TrackerIdentifier]

  Error* = ref object of RootObj
    ## The error details.
    name*: string
      ## The human-readable, unique name of the error.
    message*: string
      ## The message that describes the error.
    debug_id*: string
      ## The PayPal internal ID. Used for correlation purposes.
    information_link*: Option[string]
      ## The information link, or URI, that shows detailed information about this error
      ## for the developer.
    details*: Option[ErrorDetailsList]
    links*: Option[ErrorDefinitionsLinkDescriptionList]

  Error400* = ref object of RootObj
    ## Request is not well-formed, syntactically incorrect, or violates schema.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error401* = ref object of RootObj
    ## Authentication failed due to missing Authorization header, or invalid
    ## authentication credentials.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error403* = ref object of RootObj
    ## The client is not authorized to access this resource, although it may have valid
    ## credentials.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error404* = ref object of RootObj
    ## The server has not found anything matching the request URI. This either means
    ## that the URI is incorrect or the resource is not available.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error409* = ref object of RootObj
    ## The server has detected a conflict while processing this request.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error415* = ref object of RootObj
    ## The server does not support the request payload's media type.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error422* = ref object of RootObj
    ## The requested action cannot be performed and may require interaction with APIs
    ## or processes outside of the current request. This is distinct from a 500
    ## response in that there are no systemic problems limiting the API from performing
    ## the request.
    name*: Option[string]
    message*: Option[string]
    details*: Option[seq[ErrorDetails]]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error500* = ref object of RootObj
    ## This is either a system or application error, and generally indicates that
    ## although the client appeared to provide a correct request, something unexpected
    ## has gone wrong on the server.
    name*: Option[string]
    message*: Option[string]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  Error503* = ref object of RootObj
    ## The server is temporarily unable to handle the request, for example, because of
    ## planned maintenance or downtime.
    name*: Option[string]
    message*: Option[string]
    debug_id*: Option[string]
      ## The PayPal internal ID. Used for correlation purposes.
    links*: Option[seq[ErrorLinkDescription]]
      ## An array of request-related [HATEOAS
      ## links](https://en.wikipedia.org/wiki/HATEOAS).

  ErrorDefinitionsLinkDescriptionList* = seq[LinkDescription2]

  ErrorDetails* = ref object of RootObj
    ## The error details. Required for client-side `4XX` errors.
    field*: Option[string]
      ## The field that caused the error. If this field is in the body, set this value to
      ## the field's JSON pointer value. Required for client-side errors.
    value*: Option[string]
      ## The value of the field that caused the error.
    location*: Option[ErrorLocation]
    issue*: string
      ## The unique, fine-grained application-level error code.
    description*: Option[string]
      ## The human-readable description for an issue. The description can change over the
      ## lifetime of an API, so clients must not depend on this value.

  ErrorDetails2* = ref object of RootObj
    ## The error details. Required for client-side `4XX` errors.
    field*: Option[string]
      ## The field that caused the error. If this field is in the body, set this value to
      ## the field's JSON pointer value. Required for client-side errors.
    value*: Option[string]
      ## The value of the field that caused the error.
    location*: Option[string]
      ## The location of the field that caused the error. Value is `body`, `path`, or
      ## `query`.
    issue*: string
      ## The unique, fine-grained application-level error code.
    description*: Option[string]
      ## The human-readable description for an issue. The description can change over the
      ## lifetime of an API, so clients must not depend on this value.
    links*: Option[DefinitionsLinkDescriptionList]

  ErrorDetailsList* = seq[ErrorDetails2]

  ErrorLinkDescription* = ref object of RootObj
    ## The request-related [HATEOAS link](/api/rest/responses/#hateoas-links)
    ## information.
    href*: string
      ## The complete target URL. To make the related call, combine the method with this
      ## [URI Template-formatted](https://tools.ietf.org/html/rfc6570) link. For
      ## pre-processing, include the `$`, `(`, and `)` characters. The `href` is the key
      ## HATEOAS component that links a completed call with a subsequent call.
    rel*: string
      ## The [link relation type](https://tools.ietf.org/html/rfc5988#section-4), which
      ## serves as an ID for a link that unambiguously describes the semantics of the
      ## link. See [LinkRelations](https://www.iana.org/assignments/link-relations/link-
      ## relations.xhtml).
    `method`*: Option[string]
      ## The HTTP method required to make the related call.

  ErrorList* = seq[Error]

  ErrorLocation* = enum
    ## The location of the field that caused the error. Value is `body`, `path`, or
    ## `query`.
    body = "body"
    path = "path"
    query = "query"

  LinkDescription* = ref object of RootObj
    ## A request-related [HATEOAS link](/api/rest/responses/#hateoas-links).
    href*: string
      ## The complete target URL. To make the related call, combine the method with this
      ## link, in [URI template format](https://tools.ietf.org/html/rfc6570). Include the
      ## `$`, `(`, and `)` characters for pre-processing. The `href` is the key HATEOAS
      ## component that links a completed call with a subsequent call.
    rel*: string
      ## The [link relation type](https://tools.ietf.org/html/rfc5988#section-4), which
      ## serves as an ID for a link that unambiguously describes the semantics of the
      ## link. See [LinkRelations](https://www.iana.org/assignments/link-relations/link-
      ## relations.xhtml).
    `method`*: Option[string]
      ## The HTTP method required to make the related call.

  LinkDescription2* = ref object of RootObj
    ## The request-related [HATEOAS link](/api/rest/responses/#hateoas-links)
    ## information.
    href*: string
      ## The complete target URL. To make the related call, combine the method with this
      ## [URI Template-formatted](https://tools.ietf.org/html/rfc6570) link. For
      ## pre-processing, include the `$`, `(`, and `)` characters. The `href` is the key
      ## HATEOAS component that links a completed call with a subsequent call.
    rel*: string
      ## The [link relation type](https://tools.ietf.org/html/rfc5988#section-4), which
      ## serves as an ID for a link that unambiguously describes the semantics of the
      ## link. See [LinkRelations](https://www.iana.org/assignments/link-relations/link-
      ## relations.xhtml).
    `method`*: Option[string]
      ## The HTTP method required to make the related call.

  LinkDescriptionList* = seq[LinkDescription]

  Tracker* = ref object of RootObj
    ## The tracking information for a shipment.
    transaction_id*: string
      ## The PayPal transaction ID.
    tracking_number*: Option[string]
      ## The tracking number for the shipment. Carrier information, `carrier` is required
      ## if tracking_number is provided.
    tracking_number_type*: Option[TrackingNumberType]
    status*: TrackingStatus
    shipment_date*: Option[DateNoTime]
    carrier*: Option[Carrier]
    carrier_name_other*: Option[string]
      ## The name of the carrier for the shipment. Provide this value only if the carrier
      ## parameter is OTHER.
    postage_payment_id*: Option[string]
      ## The postage payment ID.
    notify_buyer*: Option[bool]
      ## If true , sends an email notification to the buyer of the PayPal transaction.
      ## The email contains the tracking information that was uploaded through the API.
    quantity*: Option[int64]
      ## The quantity of items shipped.
    tracking_number_validated*: Option[bool]
      ## Indicates whether the carrier validated the tracking number.
    last_updated_time*: Option[DateTime]
    shipment_direction*: Option[string]
      ## To denote whether the shipment is sent forward to the receiver or returned back.
    shipment_uploader*: Option[string]
      ## To denote which party uploaded the shipment tracking info.
    account_id*: Option[string]
      ## Encrypted PayPal Account ID of the buyer or seller.
    tracking_url*: Option[string]
      ## Tracking Link of the shipment.
    links*: Option[LinkDescriptionList]

  TrackerCollection* = ref object of RootObj
    ## The add tracking information for one or more transactions response details.
    trackers*: Option[TrackerList]
    links*: Option[LinkDescriptionList]

  TrackerIdentifier* = ref object of RootObj
    ## The tracking identifiers for a shipment.
    transaction_id*: string
      ## The PayPal transaction ID.
    tracking_number*: Option[string]
      ## The tracking number for the shipment.
    links*: Option[LinkDescriptionList]

  TrackerIdentifierCollection* = ref object of RootObj
    ## The add tracking information for a PayPal transaction response details.
    tracker_identifiers*: Option[DefinitionsTrackerIdentifierList]
    links*: Option[TrackerIdentifierCollectionDefinitionsLinkDescriptionList]

  TrackerIdentifierCollectionDefinitionsLinkDescriptionList* = seq[LinkDescription]

  TrackerIdentifierList* = seq[TrackerIdentifier]

  TrackerList* = seq[Tracker]

  TrackingNumberType* = enum
    ## The tracking number type.
    CARRIERPROVIDED = "CARRIER_PROVIDED"
    E2EPARTNERPROVIDED = "E2E_PARTNER_PROVIDED"

  TrackingStatus* = enum
    ## The status of the item shipment. For allowed values, see <a
    ## href="/docs/tracking/reference/shipping-status/">Shipping Statuses</a>.
    CANCELLED = "CANCELLED"
    DELIVERED = "DELIVERED"
    LOCALPICKUP = "LOCAL_PICKUP"
    ONHOLD = "ON_HOLD"
    SHIPPED = "SHIPPED"
    SHIPMENTCREATED = "SHIPMENT_CREATED"
    DROPPEDOFF = "DROPPED_OFF"
    INTRANSIT = "IN_TRANSIT"
    RETURNED = "RETURNED"
    LABELPRINTED = "LABEL_PRINTED"
    ERROR2 = "ERROR"
    UNCONFIRMED = "UNCONFIRMED"
    PICKUPFAILED = "PICKUP_FAILED"
    DELIVERYDELAYED = "DELIVERY_DELAYED"
    DELIVERYSCHEDULED = "DELIVERY_SCHEDULED"
    DELIVERYFAILED = "DELIVERY_FAILED"
    INRETURN = "INRETURN"
    INPROCESS = "IN_PROCESS"
    NEW = "NEW"
    VOID = "VOID"
    PROCESSED = "PROCESSED"
    NOTSHIPPED = "NOT_SHIPPED"
    COMPLETED = "COMPLETED"
