package testdata.rpc
{
	[RemoteObject(name="MyService",destination="http-destination",url="/myservice")]
	public class RemoteObjectFactory_getInstance_001
	{
		[RestOperation(method="POST",returning="MyModel")]
		public function method01():void
		{
		}
	}
}