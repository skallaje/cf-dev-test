/**
*	@output 	"false"
*	@implements "cfide.orm.IEventHandler"
*/
component
{
	public void function preInsert( any entity )
	{
		// wrap in a try/catch so these fields are not mandatory
		try {
			entity.setCreatedOn(now());
			entity.setUpdatedOn(now());
		} catch( any e ) {
			// do nothing
		}
	}

	public void function preLoad( any entity )
	{
	}

	public void function postLoad( any entity )
	{
	}

	public void function postInsert( any entity )
	{
	}

	public void function preUpdate( any entity, struct oldData )
	{
		// wrap in a try/catch so this field is not mandatory
		try {
			entity.setUpdatedOn(now());
		} catch( any e ) {
			// do nothing
		}
	}

	public void function postUpdate( any entity )
	{
	}

	public void function preDelete( any entity )
	{
	}

	public void function postDelete( any entity )
	{
	}

	public void function preFlush(any entities)
	{
	}

	public void function postFlush(any entities)
	{
	}


}