component {
	this.name = "mp-code-test";
	this.datasource = "Meetingplay_codeTest";
	this.sessionManagement = true;
	this.ormEnabled	= true;
	this.scriptprotect = "all"; //cross site scripting protection

	// orm settings
	this.ormSettings 	= {
		cfclocation 			: ["models/ormDataFiles"],
		eventhandling 			: true,
		eventhandler 			: "models.ormDataFiles.ormEventHandler",
		logSQL 					: false,
		dbcreate 				: "none", // DB SHOULD BE BUILT VIEW SQL SCRIPTS INSTEAD OF HIBERNATE
		dialect 				: "MicrosoftSQLServer",
		useDBForMapping 		: false
	};

	// lucee cache
	this.cache[this.name] = {
		"class" 	: "lucee.runtime.cache.ram.RamCache",
		"storage" 	: true,
		"custom" 	: {
			"timeToIdleSeconds":"1800",
			"timeToLiveSeconds":"3600"
		},
		"default" 	: ""
	};

	this.cache.object = this.name;

	public boolean function onApplicationStart() {
		application.zeroGuid = '00000000-0000-0000-0000-000000000000';

		application.speakerTypeService = new models.services.speakerTypeService();
		application.speakerService = new models.services.speakerService();

		//setup security service
		setupSecurityService();

		return true;
	}

	public boolean function onRequestStart( string targetPage ) {
		// reloads
		if(	structKeyExists( url, "fwreinit" ) ) {
			// lock the cache remove all so it has time to actually do it before the application stops
			lock timeout="5" name="cacheLock" type="exclusive" {
				// clear the cache before reloading
				cacheRemoveAll();
			}

			// reload
			ApplicationStop();

			location( "./", false );
		}

		// look for clearCache
		if( structKeyExists( url, "clearCache" ) ) {
			cacheRemoveAll();
		}

		return true;
	}

	/**
	 * Setup Security service using the keyring file
	 *  on windows installation path is hardcoded to folder in c:
	 *  on linux the file should exists two directories up from current folder
	 */
	private void function setupSecurityService() {
		// generate the master key using PBKDF
		var keyRingSecret = "cfCodeTest";

		var masterKey 		= generatePBKDFKey( 'PBKDF2WithHmacSHA1', keyRingSecret, hash( keyRingSecret, 'MD5', 'UTF-8', 394 ), 2048, 128 );
		// define the keyring filename to use
		var keyRingFilename = hash( 'Meetingplay', 'MD5', 'UTF-8', 369 ) & '.bin';
		var keyRingPath 	= "";
		var keyRing 		= [];
		// provide a static HMAC key using generateSecretKey( 'HMACSHA512' )
		// to be used in development environments where application reload
		// forcing re-login is undesireable (currently any environment other than 'prod')
		var developmentHmacKey = 'ZYFjB1i6KdJw0vFCg2GAhcjvDdtAgmwNqhLltcEPlFaan3Iy/Tq5I/CmH4fs+F+7Q/vRFfWVBQhSCmvA2ygSfg==';

		keyRingPath = expandPath( "./" ) & keyRingFilename;

		// get the engine we're currently deployed on
		application.engine 	= server.coldfusion.productname;

		// check if we're using Lucee
		if( findNoCase( 'lucee', application.engine ) ) {
			// we are, get the version of lucee we're running
			application.engineVersion = server.lucee.version;
		// otherwise, assume we're running ACF
		} else {
			// get the version of ACF we're running
			application.engineVersion = listFirst( server.coldfusion.productversion );
		}

		// load and initialize the SecurityService with keyring path and master key
		application.securityService = new models.services.SecurityService(
			keyRingPath = keyRingPath,
			masterKey = masterKey
		);

		// use the SecurityService to read the encryption keys from disk
		keyRing = application.securityService.readKeyRingFromDisk();

		// check if the keyring is a valid array of keys
		if( !isArray( keyRing ) || !arrayLen( keyRing ) ) {
			// it isn't, try
			try {
				// to generate a new keyring file (for new application launch only)
				//keyRing = application.securityService.generateKeyRing();
				// you should throw an error instead of attempting to generate a new
				// keyring once a keyring has already been established
				throw( 'The keyring file could not be found' );
			// catch any errors
			}
			catch ( any e ) {
				// and dump the error
				writeDump( e );
				// or throw a new error
				// throw( 'The keyring file could not be found' );
				// or otherwise log, etc. and abort
				abort;
			}
		}

		// (re)initialize the SecurityService with the keyring
		application.securityService = application.securityService.init(
			encryptionKey1          = keyRing[1].key,
			encryptionAlgorithm1    = keyRing[1].alg,
			encryptionEncoding1     = keyRing[1].enc,
			encryptionKey2          = keyRing[2].key,
			encryptionAlgorithm2    = keyRing[2].alg,
			encryptionEncoding2     = keyRing[2].enc,
			encryptionKey3          = keyRing[3].key,
			encryptionAlgorithm3    = keyRing[3].alg,
			encryptionEncoding3     = keyRing[3].enc,
			hmacKey                 = developmentHmacKey,
			hmacAlgorithm           = 'HMACSHA512',
			hmacEncoding            = 'UTF-8'
		);

		// set the name of the cookie to use for session management
		application.cookieName = '__cfCodeTest';

		// set the name of the cookie to use for device management
		application.deviceCookie = '__cfCodeTestDevice';
	}
}