///////////////////////////////////////////////////////////////////////////////
//
// Licensed Source Code - Property of f-project.net
//
// Copyright © 2014 f-project.net. All Rights Reserved.
//
///////////////////////////////////////////////////////////////////////////////
package net.fproject.model
{
	import mx.events.PropertyChangeEvent;
	
	import net.fproject.fproject_internal;

	/**
	 * Represents an user.
	 */
	public class User extends LocalUID
	{
		private var _id:String;

		[Bindable(event="propertyChange")]
		/**
		 * An unique number identity of user 
		 */
		public function get id():String
		{
			return _id;
		}

		/**
		 * @private
		 */
		public function set id(value:String):void
		{
			if( _id !== value)
			{
				var oldValue:String = _id;
				_id = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, 'id', oldValue, value));
			}
		}


		private var _username:String;

		[Bindable(event="propertyChange")]
		/**
		 * The user account name 
		 */
		public function get username():String
		{
			return _username;
		}

		/**
		 * @private
		 */
		public function set username(value:String):void
		{
			if( _username !== value)
			{
				var oldValue:String = _username;
				_username = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, 'username', oldValue, value));
			}
		}

		
		private var _token:String;
		
		[Transient]
		/**
		 * The authentication token 
		 */
		public function get token():String
		{
			return _token;
		}
		
		/**
		 * Set the authentication token 
		 */
		fproject_internal function setToken(value:String):void
		{
			_token = value;
		}
	}
}