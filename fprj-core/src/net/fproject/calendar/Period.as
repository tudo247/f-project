///////////////////////////////////////////////////////////////////////////////
//
// Licensed Source Code - Property of f-project.net
//
// Copyright © 2013 f-project.net. All Rights Reserved.
//
///////////////////////////////////////////////////////////////////////////////
package net.fproject.calendar
{
	import net.fproject.fproject_internal;
	import net.fproject.core.DateRange;
	import net.fproject.utils.DateTimeUtil;
	
	use namespace fproject_internal;
	
	/**
	 * Represents a working or a nonworking period in a <code>WorkCalendar</code>.
	 * 
	 * <p>A working period represents a time period in which the user can 
	 * specify what are the working and nonworking times for every 1 day
	 * of the period. We call a continued working time interval is 
	 * work shift (see class <code>WorkShift</code>). The period time interval 
	 * can be specified using the <code>startDate</code> and <code>endDate</code> 
	 * properties.<br/>
	 * <br/>
	 * To specify the work shifts, use the <code>workShifts</code> property. 
	 * Note that if the period is a nonworking period, the <code>workShifts</code> 
	 * property is ignored. The <code>workShifts</code> property is
	 * mandatory if the period is working period.<br/>
	 * <br/>
	 * To set a period as a nonworking period, use the <code>isWorking</code> property with 
	 * <code>false</code> value.
	 * </p>	 
	 * <p>Working times in a <code>Period</code> should be ordered, 
	 * and should not overlap.</p>
	 * 
	 * <p>The following example shows how to specify a nonworking period from 
	 * January 15 to January 20 2008: </p>
	 * 
	 * <pre>
	 * &lt;cal:WorkCalendar baseCalendar="{WorkCalendar.STANDARD}"&gt;
	 * 	&lt;cal:periods&gt;
	 * 		&lt;cal:Period start="2008/1/15" end="2008/1/20" isWorking="false" /&gt;
	 * 	&lt;/cal:periods&gt;
	 * &lt;/cal:WorkCalendar&gt;
	 * </pre> 
	 * 
	 * @mxml
	 * <p>The <code>&lt;Period&gt;</code> tag inherits all the tag attributes
	 * of its superclass and adds the following tag attributes:</p>
	 * <pre>
	 * &lt;cal:Period
	 * &lt;!--<b>Properties</b>--&gt;
	 * startDate="null"
	 * endDate="null"
	 * workShifts="<i>A vector of <code>WorkShift</code></i>"
	 * isWorking="true"
	 * /&gt;
	 * </pre>
	 * 
	 * @see WorkShift
	 */
	public class Period extends DateRange
	{		
		private var _workShifts:Vector.<WorkShift>;
		
		/**
		 * Determines whether this period is working period or not. 
		 */
		public var isWorking:Boolean;
		
		/**
		 * <p>Initializes a new instance of the <code>Period</code> 
		 * class.</p>
		 * <p>
		 * The constructor intializes this period as a working period.
		 * The <code>startDate</code> and <code>endDate</code> properties are 
		 * not set by this constructor.
		 * The <code>workShifts</code> property is not set by this constructor.
		 * </p> 
		 * 
		 * */
		public function Period(startTime:Date = null, endTime:Date = null)
		{
			super(startTime, endTime);
			this._workShifts = new Vector.<WorkShift>;
			this.isWorking = true;
		}// end function
		
		/**
		 * 
		 * <p>Gets or sets the work shifts of the period.</p>
		 * <p>Working shifts in a <code>Period</code> should be ordered, 
		 * and should not overvap.</p>
		 * 
		 */
		public function get workShifts() : Vector.<WorkShift>
		{
			return WorkShift.copyWorkShifts(this._workShifts);
		}// end function
		
		/**
		 * 
		 * @private
		 * 
		 */
		public function set workShifts(value:Vector.<WorkShift>) : void
		{
			this._workShifts = WorkShift.copyWorkShifts(value);
		}// end function
		
		/**
		 * Gets or sets the end date of the period. 
		 * 
		 */
		override public function get end() : Date
		{
			return _end != null ? new Date(_end.time) : null;
		}// end function
		
		/**
		 * 
		 * @private
		 * 
		 */
		override public function set end(value:Date) : void
		{
			this._end = (value != null ? DateTimeUtil.getStartOfDay(value) : null);
		}// end function
		
		/**
		 * Gets or sets the start date of the period. 
		 * 
		 */
		override public function get start() : Date
		{
			return _start != null ? new Date(_start.time) : null;
		}// end function
		
		/**
		 * 
		 * @private
		 * 
		 */
		override public function set start(value:Date) : void
		{
			this._start = (value != null ? DateTimeUtil.getStartOfDay(value) : null);
			
		}// end function
		
		/**
		 * Create a Period object from an PeriodInternal object 
		 * @param calendar the parent WorkCalendar
		 * @param period
		 * @return The created new Period object
		 * 
		 */
		fproject_internal static function createPeriod(p:PeriodInternal) : Period
		{
			var period:Period = new Period;
			period.start = p.startDate;
			period.end = p.endDate;
			period.isWorking = p.isWorking;
			period.workShifts = p.workShifts;
			return period;
		}// end function
	}
}
