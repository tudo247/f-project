﻿///////////////////////////////////////////////////////////////////////////////
//
// Licensed Source Code - Property of f-project.net
//
// Copyright © 2013 f-project.net. All Rights Reserved.
//
///////////////////////////////////////////////////////////////////////////////
package net.fproject.utils
{

    public class ColorUtil
    {
        public static function getHSBColor(hue:Number, saturation:Number, brightness:Number) : uint
        {
            var r:uint = 0;
            var g:uint = 0;
            var b:uint = 0;
            if (saturation == 0)
            {
				r = g = b = uint(brightness * 255 + 0.5);
            }
            else
            {
				var h:Number = (hue - Math.floor(hue)) * 6;
				var f:Number = h - Math.floor(h);
				var p:Number = brightness * (1 - saturation);
				var q:Number = brightness * (1 - saturation * f);
				var t:Number = brightness * (1 - saturation * (1 - f));
                switch(uint(h))
                {
                    case 0:
                    {
                        r = uint(brightness * 255 + 0.5);
                        g = uint(t * 255 + 0.5);
                        b = uint(p * 255 + 0.5);
                        break;
                    }
                    case 1:
                    {
                        r = uint(q * 255 + 0.5);
                        g = uint(brightness * 255 + 0.5);
                        b = uint(p * 255 + 0.5);
                        break;
                    }
                    case 2:
                    {
                        r = uint(p * 255 + 0.5);
                        g = uint(brightness * 255 + 0.5);
                        b = uint(t * 255 + 0.5);
                        break;
                    }
                    case 3:
                    {
                        r = uint(p * 255 + 0.5);
                        g = uint(q * 255 + 0.5);
                        b = uint(brightness * 255 + 0.5);
                        break;
                    }
                    case 4:
                    {
                        r = uint(t * 255 + 0.5);
                        g = uint(p * 255 + 0.5);
                        b = uint(brightness * 255 + 0.5);
                        break;
                    }
                    case 5:
                    {
                        r = uint(brightness * 255 + 0.5);
                        g = uint(p * 255 + 0.5);
                        b = uint(q * 255 + 0.5);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return r << 16 | g << 8 | b;
        }// end function

        public static function uintToRGB(color:uint) : Object
        {
            return {r:(color & 16711680) >> 16, g:(color & 65280) >> 8, b:color & 255};
        }// end function

        public static function RGBToUint(color:Object) : uint
        {
            return color.r << 16 | color.g << 8 | color.b;
        }// end function

        public static function addAlpha(color:uint, alpha:Number) : uint
        {
            color = color | (alpha * 255 & 255) << 24;
            return color;
        }// end function

    }
}
