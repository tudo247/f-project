package net.fproject.collection
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.errors.SortError;
	import mx.core.mx_internal;
	
	import net.fproject.utils.DataUtil;
	
	use namespace mx_internal;
	public class AdvancedArrayCollection extends ArrayCollection
	{
		/**
		 * The function used to compare two items, return true if and only if they are equals.
		 * Should have following signature:
		 * <pre>
		 * 	function itemEqualFunction(a:Object, b:Object):Boolean
		 * </pre>
		 */
		public var itemEqualFunction:Function;
		
		
		/**
		 * 
		 * Construct a new AdvancedArrayCollection using the a source array an a function
		 * used for comparing items.
		 * If no source is specified an empty array will be used.
		 * 
		 * @param source The Array to use as a source for the ArrayList.
		 * @param itemEqualFunction The function used to compare two items, return true if and only if they are equals.
		 * Should have following signature:
		 * <pre>
		 * 	function itemEqualFunction(a:Object, b:Object):Boolean
		 * </pre>
		 *  
		 */
		public function AdvancedArrayCollection(source:Array=null, itemEqualFunction:Function=null)
		{
			this.itemEqualFunction = itemEqualFunction == null ? DataUtil.equals : itemEqualFunction;
			super(source);
		}
		
		/**
		 *  @inheritDoc
		 */
		override public function getItemIndex(item:Object):int
		{
			if(itemEqualFunction == null)
				return super.getItemIndex(item);
			var i:int;
			
			if (localIndex && filterFunction != null)
			{
				var len:int = localIndex.length;
				for (i = 0; i < len; i++)
				{
					if (itemEqualFunction(localIndex[i], item))
						return i;
				}
				
				return -1;
			}
			else if (localIndex && sort)
			{
				var startIndex:int = findItem(item, Sort.FIRST_INDEX_MODE);
				if (startIndex == -1)
					return -1;
				
				var endIndex:int = findItem(item, Sort.LAST_INDEX_MODE);
				for (i = startIndex; i <= endIndex; i++)
				{
					if (itemEqualFunction(localIndex[i], item))
						return i;
				}
				
				return -1;
			}
				// List is sorted or filtered but refresh has not been called
			else if (localIndex)
			{
				len = localIndex.length;
				for (i = 0; i < len; i++)
				{
					if (itemEqualFunction(localIndex[i], item))
						return i;
				}
				
				return -1;
			}
			
			// fallback
			return list.getItemIndex(item);   
		}
		
		/**
		 *  @inheritDoc
		 */
		override mx_internal function findItem(values:Object, mode:String, insertIndex:Boolean = false):int
		{
			if(itemEqualFunction == null || !sort || !localIndex || localIndex.length == 0)
				return super.findItem(values, mode, insertIndex);
			
			try
			{
				return sort.findItem(localIndex, values, mode, insertIndex, 
					function(a:Object, b:Object):int
					{
						return (itemEqualFunction(a, b)) ? 0 : -1;							
					});
			}
			catch (e:SortError)
			{
				// usually because the find critieria is not compatible with the sort.
			}
			
			return -1;
		}
	}
}