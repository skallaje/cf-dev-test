component displayname="UtilService" accessors="true" singleton {

	public function init() {
		return this;
	}

	/**
	 * Converts a query object into an array of structures.
	 * https://cflib.org/udf/QueryToArrayOfStructures
	 * @param query      The query to be transformed
	 * @return This function returns an array.
	 * @author Nathan Dintenfass (nathan@changemedia.com)
	 * @version 1, September 27, 2001
	 */
	function QueryToArrayOfStructures( required query theQuery ) {
		var theArray = [];
		//var cols = listtoArray( arguments.theQuery.columnlist );
		var cols = theQuery.getMeta().getColumnLabels();
		var row = 1;
		var thisRow = "";
		var col = 1;
		for( row = 1; row LTE theQuery.recordcount; row = row + 1 ) {
			thisRow = {};

			for( col = 1; col LTE arraylen( cols ); col = col + 1 ) {
				thisRow[ cols[ col ] ] = arguments.theQuery[ cols[ col ] ][ row ];
			}

			arrayAppend( theArray, duplicate( thisRow ) );
		}
		return( theArray );
	}
}