## -------------------------------------------------------------------------------------------------------------
## class to parse the street suffix and return the 3 character uniform street
##
class StreetSuffixParser

    # @property [Object] suffixes suffixes taken from http://pe.usps.gov/text/pub28/28apc_002.htm
    suffixes:
        ALY : ['ALLEE','ALLEY','ALLY','ALY']
        ANX : ['ANEX','ANNEX','ANNX','ANX']
        ARC : ['ARC','ARCADE']
        AVE : ['AVE','AVEN','AV','AVENU','AVENUE','AVN','AVNUE']
        BYU : ['BAYOO','BAYOU']
        BCH: ['BCH','BEACH']
        BND: ['BEND','BND']
        BLF: ['BLF','BLUFF','BLUF']
        BLFS: ['BLUFFS']
        BTM: ['BOT','BTM','BOTTOM','BOTTM']
        BLVD:['BLVD','BOUL','BOULEVARD','BOULV']
        BR: ['BR','BRNCH','BRANCH']
        BRG: ['BRDGE','BRIDGE','BRG']
        BRK: ['BROOK','BRK']
        BRKS: ['BROOKS']
        BG: ['BURG']
        BGS: ['BURGS']
        BYP: ['BYP','BYPA','BYPAS','BYPASS','BYPS']
        CP: ['CAMP','CP','CMP']
        CYN: ['CANYN','CANYON','CNYN']
        CPE: ['CAPE','CPE']
        CSWY: ['CAUSEWAY','CAUSWA','CSWY']
        CTR: ['CEN','CENT','CENTER','CENTR','CENTRE','CNTER','CNTR','CTR']
        CTRS: ['CENTERS']
        CIR: ['CIR','CIRC','CIRCL','CIRCLE','CRCL','CRCLE']
        CIRS: ['CIRCLES']
        CLF: ['CLF','CLIFF']
        CLFS: ['CLFS','CLIFFS']
        CLB: ['CLUB','CLB']
        CMN: ['COMMON']
        CMNS: ['COMMONS']
        COR: ['COR','CORNOR']
        CORS: ['CORS','CORNORS']
        CRSE: ['CRSE','COURSE']
        CT: ['CT','COURT']
        CTS: ['CTS','COURTS']
        CV: ['COVE','CV']
        CVS: ['COVES']
        CRK: ['CREEK','CRK']
        CRES: ['CRESCENT','CRES','CRSENT','CRSNT']
        CRST: ['CREST']
        XING: ['CROSSING','CRSSNG','XING']
        XRD: ['CROSSROAD']
        XRDS: ['CROSSROADS']
        CURV: ['CURVE']
        DL: ['DALE','DL']
        DM: ['DAM','DM']
        DV: ['DIVIDE','DIV','DV','DVD']
        DR: ['DRIV','DR','DRIVE','DRV']
        DRS: ['DRIVES']
        EST: ['ESTATE','EST']
        ESTS: ['ESTATES','ESTS']
        EXPY: ['EXPRESS','EXP','EXPR','EXPRESSWAY','EXPW','EXPY']
        EXT: ['EXTENSION','EXT','EXTN','EXTNSN']
        EXTS: ['EXTS']
        FALL: ['FALL']
        FLS: ['FALLS','FLS']
        FRY: ['FERRY','FRRY','FRY']
        FLD: ['FIELD','FLD']
        FLDS: ['FIELDS','FLDS']
        FLT: ['FLT','FLAT']
        FLTS: ['FLATS','FLTS']
        FRD: ['FORD','FRD']
        FRDS: ['FORDS']
        FRST: ['FOREST','FORESTS','FRST']
        FRG: ['FORG','FORGE','FRG']
        FRGS: ['FORGES']
        FRK: ['FORK','FRK']
        FRKS: ['FORKS','FRKS']
        FT: ['FORT','FT','FRT']
        FWY: ['FREEWAY','FREEWY','FRWAY','FRWY','FWY']
        GDN: ['GARDEN','GARDN','GRDEN','GRDN'],
        GDNS: ['GARDENS','GDNS','GRDNS']
        GTWY: ['GATEWAY','GATEWY','GATWAY','GTWAY','GTWY']
        GLN: ['GLEN','GLN']
        GLNS: ['GLENS']
        GRN: ['GRN','GREEN']
        GRNS: ['GREENS']
        GRV: ['GROV','GROVE','GRV']
        GRVS: ['GROVES']
        HBR: ['HARB','HARBOR','HARBR','HRBOR','HBR']
        HBRS: ['HARBORS']
        HVN: ['HAVEN','HVN']
        HTS: ['HT','HTS']
        HWY: ['HIGHWAY','HIGHWY','HIWAY','HIWY','HWAY','HWY']
        HL: ['HL','HILL']
        HLS: ['HLS','HILLS']
        HOLW: ['HLLW','HOLLOW','HOLLOWS','HOLW','HOLWS']
        INLT: ['INLT']
        IS: ['ISLAND','IS','ISLND']
        ISS: ['ISLANDS','ISS','ISLNDS']
        ISLE: ['ISLE','ISLES']
        JCT: ['JCTION','JCT','JCTN','JUNCTION','JUNCTN','JUNCTON']
        JCTS: ['JCTNS','JCTS','JUNCTIONS']
        KY: ['KEY','KY']
        KYS: ['KEYS','KYS']
        KNL: ['KNL','KNOL','KNOLL']
        KNLS: ['KNLS','KNOLLS']
        LK: ['LAKE','LK']
        LKS: ['LAKES','LKS']
        LAND: ['LAND']
        LNDG: ['LANDING','LNDNG','LNDG']
        LN: ['LN','LANE']
        LGT: ['LGN','LIGHT']
        LGTS: ['LIGTHS']
        LF: ['LF','LOAF']
        LCK: ['LCK','LOCK']
        LCKS: ['LCKS','LOCKS']
        LDG: ['LDG','LDGE','LODG','LODGE']
        LOOP: ['LOOP','LOOPS']
        MALL: ['MALL']
        MNR: ['MANOR','MNR']
        MNRS: ['MANORS','MNRS']
        MDW: ['MEADOW']
        MDWS: ['MDWS','MDW','MEADOWS','MEDOWS']
        MEWS: ['MEWS']
        ML: ['MILL']
        MLS: ['MILLS']
        MSN: ['MISSN','MSSN']
        MTWY: ['MOTORWAY']
        MT: ['MNT','MT','MOUNT']
        MTN: ['MNTAIN','MNTN','MOUNTAIN','MOUNTIN','MTIN','MTN']
        MTNS: ['MOUNTAINS','MNTNS']
        NCK: ['NECK','NCK']
        ORCH: ['ORCH','ORCHARD','ORCHRD']
        OVAL: ['OVAL','OVL']
        OPAS: ['OVERPASS']
        PARK: ['PARK','PRK']
        PARK: ['PARKS']
        PKWY: ['PARKWAY','PARKWY','PKWAY','PKWY','PKY']
        PKWYS: ['PARKWAYS','PKWYS']
        PASS: ['PASS']
        PSGE: ['PASSAGE']
        PATH: ['PATH','PATHS']
        PIKE: ['PIKE','PIKES']
        PNE: ['PINE']
        PNES: ['PINES','PNES']
        PL: ['PL']
        PLN: ['PLAIN','PLN']
        PLNS: ['PLAINS','PLNS']
        PLZ: ['PLAZA','PLZ','PLZA']
        PT: ['PT','POINT']
        PTS: ['PTS','POINTS']
        PRT: ['PRT','PORT']
        PRTS: ['PRTS','PORTS']
        PR: ['PRAIRIE','PR','PRR']
        RADL: ['RADL','RADIAL','RAD','RADIEL']
        RAMP: ['RAMP']
        RNCH: ['RANCH','RANCHES','RNCH','RNCHS']
        RPD: ['RAPID','RPD']
        RPDS: ['RAPIDS','RPDS']
        RST: ['REST','RST']
        RDG: ['RDG','RDGE','RIDGE']
        RDGS: ['RIDGES','RDGS']
        RIV: ['RIV','RIVER','RVR','RIVR']
        RD: ['ROAD','RD']
        RDS: ['ROADS','RDS']
        RTE: ['ROUTE']
        ROW: ['ROW']
        RUE: ['RUE']
        RUN: ['RUN']
        SHL: ['SHOAL','SHL']
        SHLS: ['SHOALS','SHLS']
        SHR: ['SHOAR','SHORE','SHR']
        SHRS: ['SHOARS','SHORES','SHRS']
        SKWY: ['SKYWAY']
        SPG: ['SPNG','SPG','SPRING','SPRNG']
        SPGS: ['SPNGS','SPGS','SPRINGS','SPRNGS']
        SPUR: ['SPUR']
        SPURS: ['SPURS']
        SQ: ['SQ','SQR','SQRE','SQU','SQUARE']
        SQS: ['SQRS','SQUARES']
        STA: ['STATION','STA','STATN','STN']
        STRA: ['STRA','STRAV','STRAVEN','STRAVENUE','STRAVN','STRVN','STRVNUE']
        STRM: ['STREAM','STRM','STREME']
        ST: ['STREET','STRT','ST','STR']
        STS: ['STREETS']
        SMT: ['SMT','SUMIT','SUMITT','SUMMIT']
        TER: ['TER','TERR','TERRACE']
        TRWY: ['THROUGHWAY']
        TRCE: ['TRACE','TRACES','TRCE']
        TRAK: ['TRACK','TRACKS','TRAK','TRKS','TRK']
        TRFY: ['TRAFFICWAY']
        TRL: ['TRAIL','TRAILS','TRL','TRLS']
        TRLR: ['TRAILER','TRLR','TRLRS']
        TUNL: ['TUNEL','TUNL','TUNLS','TUNNEL','TUNNELS','TUNNL']
        TPKE: ['TRNPK','TURNPIKE','TURNPK']
        UPAS: ['UNDERPASS']
        UN: ['UN','UNION']
        UNS: ['UNIONS']
        VLY: ['VALLEY','VALLY','VLLY','VLY']
        VLYS: ['VALLEYS','VLYS']
        VIA: ['VDCT','VIA','VIADCT','VIADUCT']
        VW: ['VIEW','VW']
        VWS: ['VIEWS','VWS']
        VLG: ['VILL','VILLAG','VILLAGE','VILLG','VILLIAGE','VLG']
        VLGS: ['VILLAGES','VLGS']
        VL: ['VILLE','VL']
        VIS: ['VIS','VIST','VISTA','VST','VSTA']
        WALK: ['WALK']
        WALK: ['WALKS']
        WALL: ['WALL']
        WAY: ['WY','WAY']
        WAYS: ['WAYS']
        WL: ['WELL']
        WLS: ['WELLS','WLS']


	## -------------------------------------------------------------------------------------------------------------
	## function to get the suffix from name
	##
	## @param [String] name the name of the street
	## @return [String] suffix returns the short form of the street
	##
    getSuffix:(name) =>
        suffix = null
        keys = Object.keys @suffixes
        keys.forEach (key)=>
            @suffixes[key].forEach (f) ->
                if f.toLowerCase() is name.toLowerCase()
                    suffix = key
        suffix

try
	# create global instance of StreetSuffixParser
    GlobalStreetSuffixParser = new StreetSuffixParser();
catch e
    console.log "Exception while registering global Address Formatter:", e
