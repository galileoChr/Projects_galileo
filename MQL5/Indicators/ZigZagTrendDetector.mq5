//=====================================================================
//	Trend indicator.
//=====================================================================
#property copyright 	"Dima S."
#property link      	"dimascub@mail.com"
#property version   	"1.01"
#property description "Trend indicator based on ZigZag indicator."
//---------------------------------------------------------------------
#property indicator_separate_window
//---------------------------------------------------------------------
#property indicator_applied_price	PRICE_CLOSE
#property indicator_minimum				-1.4
#property indicator_maximum				+1.4
//---------------------------------------------------------------------
#property indicator_buffers 	3
#property indicator_plots   	1
//---------------------------------------------------------------------
#property indicator_type1   	DRAW_HISTOGRAM
#property indicator_color1  	Black
#property indicator_width1		2
//---------------------------------------------------------------------
//	External parameters:
//---------------------------------------------------------------------
input int   ExtDepth=12;
input int   ExtDeviation= 5;
input int   ExtBackstep = 3;
//---------------------------------------------------------------------
double   TrendBuffer[];
double   ZigZagHighs[];   // zigzag's upper turnarounds
double   ZigZagLows[ ];   // zigzag's lower turnarounds
//---------------------------------------------------------------------
int      indicator_handle=0;
//---------------------------------------------------------------------
//	Initialization event handler:
//---------------------------------------------------------------------
int OnInit()
  {
//	Displayed indicator buffer:
   SetIndexBuffer(0,TrendBuffer,INDICATOR_DATA);
   PlotIndexSetInteger(0,PLOT_DRAW_BEGIN,ExtDepth);
   PlotIndexSetString(0,PLOT_LABEL,"ZigZagTrendDetector( "
                      +(string)ExtDepth+", "
                      +(string)ExtDeviation+", "
                      +(string) ExtBackstep+" )");

//	Buffers to store zigzag's turnarounds:
   SetIndexBuffer(1,ZigZagHighs,INDICATOR_CALCULATIONS);
   SetIndexBuffer(2,ZigZagLows,INDICATOR_CALCULATIONS);

//	Create external indicator handle for future reference to it:
   ResetLastError();
   indicator_handle=iCustom(Symbol(),PERIOD_CURRENT,"Examples\\ZigZag",ExtDepth,ExtDeviation,ExtBackstep);
   if(indicator_handle==INVALID_HANDLE)
     {
      Print("ZigZag initialization error, Code = ",GetLastError());
      return(-1);     // return nonzero code - initialization was unsuccessful
     }

   return(0);
  }
//---------------------------------------------------------------------
//	Indicator deinitialization event handler:
//---------------------------------------------------------------------
void OnDeinit(const int _reason)
  {
//	Delete ZigZag indicator handle:
   if(indicator_handle!=INVALID_HANDLE)
     {
      IndicatorRelease(indicator_handle);
     }
  }
//---------------------------------------------------------------------
//	Need for indicator recalculation event handler:
//---------------------------------------------------------------------
int OnCalculate(const int _rates_total,
                const int _prev_calculated,
                const int _begin,
                const double &_price[])
  {
   int   start,i;

//	If number of bars on the screen is less than number of bars for plotting zigzag's turnaround, calculations can't be made:
   if(_rates_total<ExtDepth)
     {
      return(0);
     }

//	Determine the initial bar for indicator buffer calculation:
   if(_prev_calculated==0)
     {
      start=ExtDepth;
     }
   else
     {
      start=_prev_calculated-1;
     }

//	Copy upper and lower zigzag's turnarounds to buffers:
   CopyBuffer(indicator_handle,1,0,_rates_total-_prev_calculated,ZigZagHighs);
   CopyBuffer(indicator_handle,2,0,_rates_total-_prev_calculated,ZigZagLows);

//	Loop of calculating the indicator buffer values:
   for(i=start; i<_rates_total; i++)
     {
      TrendBuffer[i]=TrendDetector(i);
     }

   return(_rates_total);
  }

//---------------------------------------------------------------------
//	Determine the current trend direction:
//---------------------------------------------------------------------
//	Returns:
//		-1 - Down trend
//		+1 - Up trend
//		 0 - trend is not defined
//---------------------------------------------------------------------
double   ZigZagExtHigh[2];
double   ZigZagExtLow[2];
//---------------------------------------------------------------------
int TrendDetector(int _shift)
  {
   int   trend_direction=0;

//	Find last four zigzag's turnarounds:
   int   ext_high_count= 0;
   int   ext_low_count = 0;

   for(int i=_shift; i>=0; i--)
     {
      if(ZigZagHighs[i]>0.1)
        {
         if(ext_high_count<2)
           {
            ZigZagExtHigh[ext_high_count]=ZigZagHighs[i];
            ext_high_count++;
           }
        }
      else if(ZigZagLows[i]>0.1)
        {
         if(ext_low_count<2)
           {
            ZigZagExtLow[ext_low_count]=ZigZagLows[i];
            ext_low_count++;
           }
        }
      //	If two pairs of extrema are found, break the loop:
      if(ext_low_count==2 && ext_high_count==2)
        {
         break;
        }
     }

//	If required number of extrema is not found, the trend can't be determined:
   if(ext_low_count!=2 || ext_high_count!=2)
     {
      return(trend_direction);
     }

//	Check Dow's condition fulfillment:
   if(ZigZagExtHigh[0]>ZigZagExtHigh[1] && ZigZagExtLow[0]>ZigZagExtLow[1])
     {
      trend_direction=1;
     }
   else if(ZigZagExtHigh[0]<ZigZagExtHigh[1] && ZigZagExtLow[0]<ZigZagExtLow[1])
     {
      trend_direction=-1;
     }

   return(trend_direction);
  }
//+------------------------------------------------------------------+
