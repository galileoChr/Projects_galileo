//+------------------------------------------------------------------+
//|                                Indicator: BLW Turbo Strategy.mq5 |
//|                                       Created with EABuilder.com |
//|                                            https://eabuilder.com |
//+------------------------------------------------------------------+
#property copyright "Created with EABuilder.com"
#property link      "https://eabuilder.com"
#property version   "1.00"
#property description ""

//--- indicator settings
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots 2

#property indicator_type1 DRAW_ARROW
#property indicator_width1 3
#property indicator_color1 0xFFAA00
#property indicator_label1 "CALL"

#property indicator_type2 DRAW_ARROW
#property indicator_width2 3
#property indicator_color2 0x0000FF
#property indicator_label2 "PUT"

//--- indicator buffers
double Buffer1[];
double Buffer2[];

datetime time_alert; //used when sending alert
input bool Send_Email = true;
input bool Audible_Alerts = true;
input bool Push_Notifications = true;
double myPoint; //initialized in OnInit
int MA_handle;
double MA[];
int MA_handle2;
double MA2[];
double Low[];
int ATR_handle;
double ATR[];
double High[];

void myAlert(string type, string message)
  {
   if(type == "print")
      Print(message);
   else if(type == "error")
     {
      Print(type+" | BLW Turbo Strategy @ "+Symbol()+","+IntegerToString(Period())+" | "+message);
     }
   else if(type == "order")
     {
     }
   else if(type == "modify")
     {
     }
   else if(type == "indicator")
     {
      if(Audible_Alerts) Alert(type+" | BLW Turbo Strategy @ "+Symbol()+","+IntegerToString(Period())+" | "+message);
      if(Send_Email) SendMail("BLW Turbo Strategy", type+" | BLW Turbo Strategy @ "+Symbol()+","+IntegerToString(Period())+" | "+message);
      if(Push_Notifications) SendNotification(type+" | BLW Turbo Strategy @ "+Symbol()+","+IntegerToString(Period())+" | "+message);
     }
  }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {   
   SetIndexBuffer(0, Buffer1);
   PlotIndexSetDouble(0, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   PlotIndexSetInteger(0, PLOT_ARROW, 241);
   SetIndexBuffer(1, Buffer2);
   PlotIndexSetDouble(1, PLOT_EMPTY_VALUE, EMPTY_VALUE);
   PlotIndexSetInteger(1, PLOT_ARROW, 242);
   //initialize myPoint
   myPoint = Point();
   if(Digits() == 5 || Digits() == 3)
     {
      myPoint *= 10;
     }
   MA_handle = iMA(NULL, PERIOD_CURRENT, 8, 0, MODE_SMA, PRICE_CLOSE);
   if(MA_handle < 0)
     {
      Print("The creation of iMA has failed: MA_handle=", INVALID_HANDLE);
      Print("Runtime error = ", GetLastError());
      return(INIT_FAILED);
     }
   
   MA_handle2 = iMA(NULL, PERIOD_CURRENT, 14, 0, MODE_SMA, PRICE_CLOSE);
   if(MA_handle2 < 0)
     {
      Print("The creation of iMA has failed: MA_handle2=", INVALID_HANDLE);
      Print("Runtime error = ", GetLastError());
      return(INIT_FAILED);
     }
   
   ATR_handle = iATR(NULL, PERIOD_CURRENT, 14);
   if(ATR_handle < 0)
     {
      Print("The creation of iATR has failed: ATR_handle=", INVALID_HANDLE);
      Print("Runtime error = ", GetLastError());
      return(INIT_FAILED);
     }
   
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime& time[],
                const double& open[],
                const double& high[],
                const double& low[],
                const double& close[],
                const long& tick_volume[],
                const long& volume[],
                const int& spread[])
  {
   int limit = rates_total - prev_calculated;
   //--- counting from 0 to rates_total
   ArraySetAsSeries(Buffer1, true);
   ArraySetAsSeries(Buffer2, true);
   //--- initial zero
   if(prev_calculated < 1)
     {
      ArrayInitialize(Buffer1, 0);
      ArrayInitialize(Buffer2, 0);
     }
   else
      limit++;
   datetime Time[];
   
   if(BarsCalculated(MA_handle) <= 0) 
     { 
      return(0); 
     }
   if(CopyBuffer(MA_handle, 0, 0, rates_total, MA) <= 0) return(rates_total);
   ArraySetAsSeries(MA, true);
   if(BarsCalculated(MA_handle2) <= 0) 
     { 
      return(0); 
     }
   if(CopyBuffer(MA_handle2, 0, 0, rates_total, MA2) <= 0) return(rates_total);
   ArraySetAsSeries(MA2, true);
   if(CopyLow(Symbol(), PERIOD_CURRENT, 0, rates_total, Low) <= 0) return(rates_total);
   ArraySetAsSeries(Low, true);
   if(BarsCalculated(ATR_handle) <= 0) 
     { 
      return(0); 
     }
   if(CopyBuffer(ATR_handle, 0, 0, rates_total, ATR) <= 0) return(rates_total);
   ArraySetAsSeries(ATR, true);
   if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, rates_total, High) <= 0) return(rates_total);
   ArraySetAsSeries(High, true);
   if(CopyTime(Symbol(), Period(), 0, rates_total, Time) <= 0) return(rates_total);
   ArraySetAsSeries(Time, true);
   //--- main loop
   for(int i = limit-1; i >= 0; i--)
     {
      if (i >= MathMin(5000-1, rates_total-1-50)) continue; //omit some old rates to prevent "Array out of range" or slow calculation   
      //Indicator Buffer 1
      if(MA[i] > MA2[i]
      && MA[i+1] < MA2[i+1] //Moving Average crosses above Moving Average
      )
        {
         Buffer1[i] = Low[i] - ATR[i]; //Set indicator value at Candlestick Low - Average True Range
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "CALL"); time_alert = Time[0];} //Instant alert, only once per bar
        }
      else
        {
         Buffer1[i] = EMPTY_VALUE;
        }
      //Indicator Buffer 2
      if(MA[i] < MA2[i]
      && MA[i+1] > MA2[i+1] //Moving Average crosses below Moving Average
      )
        {
         Buffer2[i] = High[i] + ATR[i]; //Set indicator value at Candlestick High + Average True Range
         if(i == 0 && Time[0] != time_alert) { myAlert("indicator", "PUT"); time_alert = Time[0]; } //Instant alert, only once per bar
        }
      else
        {
         Buffer2[i] = EMPTY_VALUE;
        }
     }
   return(rates_total);
  }
//+------------------------------------------------------------------+