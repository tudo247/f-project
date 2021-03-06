﻿///////////////////////////////////////////////////////////////////////////////
//
// Licensed Source Code - Property of f-project.net
//
// Copyright © 2013 f-project.net. All Rights Reserved.
//
///////////////////////////////////////////////////////////////////////////////
package net.fproject.utils
{
    import flash.display.*;
    import flash.text.*;
    import mx.core.*;

    public class InstanceCache
    {
        private var _parent:Object;
        private var _class:Class = null;
        private var _instanceCount:int = 0;
        public var creationCallback:Function;
        public var destructionCallback:Function;
        private var _factory:IFactory;
        private var _format:TextFormat;
        private var _instances:Array;

        public function InstanceCache(factoryOrClass:Object, parent:DisplayObjectContainer = null)
        {
            this._instances = [];
            this._parent = parent;
            if (factoryOrClass is IFactory)
            {
                this._factory = IFactory(factoryOrClass);
            }
            else if (factoryOrClass is Class)
            {
                this._class = Class(factoryOrClass);
                this._factory = new ContextualClassFactory(Class(factoryOrClass));
            }
        }// end function

        public function get count() : int
        {
            return this._instanceCount;
        }// end function

        public function set count(value:int) : void
        {
            if (value == this._instanceCount)
            {
                return;
            }
            var i:int = value;
            var len:uint = this._instances.length;
            var eltContainer:IVisualElementContainer = this._parent as IVisualElementContainer;
            if (i > _instanceCount)
            {
                if (!this._factory)
                {
                    value = 0;
                }
                else
                {
					var j:int = 0;
                    for (j = 0; j < i && j < len; j++)
                    {                        
                        this._instances[j].visible = true;
                    }
                    while (j < i)
                    {                        
						var instance:Object = this._factory.newInstance();
                        if (this._parent)
                        {
                            if (eltContainer != null)
                            {
                                eltContainer.addElement(instance as IVisualElement);
                                if (instance is IInvalidating)
                                {
                                    IInvalidating(instance).validateNow();
                                }
                            }
                            else
                            {
                                this._parent.addChild(instance);
                            }
                        }
                        if (this.creationCallback != null)
                        {
                            this.creationCallback(instance, this);
                        }
                        this._instances.push(instance);
                        j++;
                    }
                    if (this._format)
                    {
                        this.applyFormat(len, i);
                    }
                }
            }
            else if (i < _instanceCount)
            {
                for (j = i; j < _instanceCount; j++)
                {                    
                    this._instances[j].visible = false;
                }
            }
            this._instanceCount = value;
        }// end function

        public function get factory() : IFactory
        {
            return this._factory;
        }// end function

        public function set factory(value:IFactory) : void
        {
            if (value == this._factory || value is ClassFactory && this._factory is ClassFactory && ClassFactory(this._factory).generator == ClassFactory(value).generator && !(value is ContextualClassFactory))
            {
                return;
            }
            var instCnt:int = this._instanceCount;
            this.discard();
            this._factory = value;
            this._class = null;
            this.count = instCnt;
        }// end function

        public function get format() : TextFormat
        {
            return this._format;
        }// end function

        public function set format(value:TextFormat) : void
        {
            this._format = value;
            if (this._format)
            {
                this.applyFormat(0, this._instances.length);
            }
        }// end function

        public function get instances() : Array
        {
            return this._instances;
        }// end function

        public function discard() : void
        {
            if (this._parent)
            {
				var eltContainer:IVisualElementContainer = this._parent as IVisualElementContainer;
                for (var i:int = 0; i < this._instanceCount; i++)
                {                    
                    if (this.destructionCallback != null)
                    {
                        this.destructionCallback(this._instances[i], this);
                    }
                    if (eltContainer != null)
                    {
                        eltContainer.removeElement(this._instances[i]);
                    }
                    else
                    {
                        this._parent.removeChild(this._instances[i]);
                    }
                }
            }
            this._instanceCount = 0;
            this._instances = [];
        }// end function

        private function applyFormat(from:int, to:int) : void
        {
            for (var i:int = from; i < to; i++)
            {                
				var instance:Object = this._instances[i];
                instance.setTextFormat(this._format);
                instance.defaultTextFormat = this._format;
            }
        }// end function

    }
}
