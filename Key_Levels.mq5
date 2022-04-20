//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property version "2.0"
#property strict

input string H=" --- Mode_Settings ---";
input bool Show_00_50_Levels=false;
input bool Show_20_80_Levels=true;
input color Level_00_Color=clrLime;
input color Level_50_Color=clrGray;
input color Level_20_Color=clrRed;
input color Level_80_Color=clrGreen;

double dXPoint=1;
double Div=0;
double i=0;
double HighPrice= 0;
double LowPrice = 0;
int iDigits;
double level_00Array[140];
double level_50Array[140];
double level_20Array[140];
double level_80Array[140];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,level_00Array,INDICATOR_DATA);
   SetIndexBuffer(1,level_20Array,INDICATOR_DATA);
   SetIndexBuffer(2,level_50Array,INDICATOR_DATA);
   SetIndexBuffer(3,level_80Array,INDICATOR_DATA);

   iDigits=_Digits;
   if(_Digits==5 || _Digits==3)
      dXPoint=10;
   if(_Digits==3)
      iDigits=2;
   if(_Digits==5)
      iDigits=4;

   Div=0.1/(_Point*dXPoint);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(
   const int rates_total,
   const int prev_calculated,
   const datetime &time[],
   const double &open[],
   const double &high[],
   const double &low[],
   const double &close[],
   const long &tick_volume[],
   const long &volume[],
   const int &spread[]
)
  {
   ArraySetAsSeries(high,true);
   ArraySetAsSeries(low,true);
   ArraySetAsSeries(time,true);
   int ih=ArrayMaximum(high, 2);
   if(ih<0)
      return rates_total;
   int il=ArrayMinimum(low,2);
   if(il<0)
      return rates_total;
//HighPrice= MathRound((high[ih]+1)*Div); this is before
//LowPrice = MathRound((low[il]-1)*Div); this is before
   HighPrice= MathRound((ChartGetDouble(_Symbol,CHART_PRICE_MAX,0)+1)*Div);
   LowPrice = MathRound((ChartGetDouble(_Symbol,CHART_PRICE_MIN,0)-1)*Div);
   if(Show_00_50_Levels)
     {
      for(i=LowPrice; i<=HighPrice; i++)
        {
         if(MathMod(i,5)==0.0)
           {
            string name="RoundPrice "+DoubleToString(i,0);
            if(ObjectFind(0,name)!=0)
              {
               ObjectCreate(0,name,OBJ_HLINE,0,time[1],i/Div);
               ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
               if(MathMod(i,10)==0.0)
                 {
                  ObjectSetInteger(0,name,OBJPROP_COLOR,Level_00_Color);
                  level_00Array[0]  = ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0);
                 }

               else
                 {
                  ObjectSetInteger(0,name,OBJPROP_COLOR,Level_50_Color);
                  level_50Array[0]  = ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0);
                 }

              }
           }
        }

     }

   if(Show_20_80_Levels)
     {
      for(i=LowPrice; i<=HighPrice; i++)
        {
         if(StringSubstr(DoubleToString(i/Div,iDigits),StringLen(DoubleToString(i/Div,iDigits))-2,2)=="20")
           {
            string name="RoundPrice "+DoubleToString(i,0);
            if(ObjectFind(0,name)!=0)
              {
               ObjectCreate(0,name,OBJ_HLINE,0,time[1],i/Div);
               ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
               ObjectSetInteger(0,name,OBJPROP_COLOR,Level_20_Color);
               level_20Array[0]  = ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0);
              }
           }
         if(StringSubstr(DoubleToString(i/Div,iDigits),StringLen(DoubleToString(i/Div,iDigits))-2,2)=="80")
           {
            string name="RoundPrice "+DoubleToString(i,0);
            if(ObjectFind(0,name)!=0)
              {
               ObjectCreate(0,name,OBJ_HLINE,0,time[1],i/Div);
               ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_SOLID);
               ObjectSetInteger(0,name,OBJPROP_COLOR,Level_80_Color);

               if(ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0)-1 <= ChartGetDouble(_Symbol,CHART_PRICE_MAX,0)
                     && ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0)-1 >= ChartGetDouble(_Symbol,CHART_PRICE_MIN,0))
              {
               Print("This is from indicator: "+" i: "+i+" "+ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0));
                  level_80Array[0]  = ObjectGetDouble(_Symbol,name,OBJPROP_PRICE,0);
                 }

              }
           }
        }
     }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   return(rates_total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Comment("");
   ObjectsDeleteAll(0,"Round");
  }
//+------------------------------------------------------------------+
