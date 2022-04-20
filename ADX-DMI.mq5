//+------------------------------------------------------------------+
//|                                                      ADX-DMI.mq5 |
//|                                  Copyright 2021, Christophe Manzi|
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Christophe Manzi."
#property link      "https://www.mql5.com"
#property version   "1.00"
//#include "DonCH EA.mq5";
#include <Trade\Trade.mqh>
CTrade trade;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int adx_indicator_handle, dmi_indicator_handle;
int adx_indicator_handle_MN1, adx_indicator_handle_D1, adx_indicator_handle_H4;
int adx_indicator_handle_H1, adx_indicator_handle_M30, adx_indicator_handle_M15,adx_indicator_handle_M5;
int indicator_handleSupportResistanceL,indicator_handleSupportResistanceL_2,indicator_handleSupportResistanceL_Random;

int indicator_handlePTL_2_MN1, indicator_handlePTL_2_D1, indicator_handlePTL_2_H4, indicator_handlePTL_2_H1;
int indicator_handlePTL_2_M30, indicator_handlePTL_2_M15, indicator_handlePTL_2_M5;

int indicator_handleSupRes, indicator_handleSupRes_MN, indicator_handleSupRes_D1,indicator_handleSupRes_H4;
int indicator_handleSupRes_H1,indicator_handleSupRes_M30, indicator_handleSupRes_M15, indicator_handleSupRes_M5;

int indicator_handlePatterns_MN1, indicator_handlePatterns_D1, indicator_handlePatterns_H4, indicator_handlePatterns_H1;
int indicator_handlePatterns_M30, indicator_handlePatterns_M15, indicator_handlePatterns_M5;

int indicator_handlePivot_MN1,indicator_handlePivot_D1,indicator_handlePivot_H4,indicator_handlePivot_H1;

int indicator_customMA_MN1_1, indicator_customMA_MN1_2,indicator_customMA_D1_1,indicator_customMA_D1_2;
int indicator_customMA_H4_1,indicator_customMA_H4_2,indicator_customMA_H1_1,indicator_customMA_H1_2;
int indicator_customMA_M30_1,indicator_customMA_M30_2,indicator_customMA_M15_1,indicator_customMA_M15_2;
int indicator_customMA_M5_1,indicator_customMA_M5_2;

enum enPrices
  {
   pr_close,      // Close
   pr_open,       // Open
   pr_high,       // High
   pr_low,        // Low
   pr_median,     // Median
   pr_typical,    // Typical
   pr_weighted,   // Weighted
   pr_average,    // Average (high+low+open+close)/4
   pr_medianb,    // Average median body (open+close)/2
   pr_tbiased,    // Trend biased price
   pr_tbiased2,   // Trend biased (extreme) price
   pr_haclose,    // Heiken ashi close
   pr_haopen,     // Heiken ashi open
   pr_hahigh,     // Heiken ashi high
   pr_halow,      // Heiken ashi low
   pr_hamedian,   // Heiken ashi median
   pr_hatypical,  // Heiken ashi typical
   pr_haweighted, // Heiken ashi weighted
   pr_haaverage,  // Heiken ashi average
   pr_hamedianb,  // Heiken ashi median body
   pr_hatbiased,  // Heiken ashi trend biased price
   pr_hatbiased2  // Heiken ashi trend biased (extreme) price
  };
enum enMaTypes
  {
   ma_sma,    // Simple moving average
   ma_ema,    // Exponential moving average
   ma_smma,   // Smoothed MA
   ma_lwma    // Linear weighted MA
  };
input int       DmiPeriod   = 20;        // DMI period
input enMaTypes DmiMaMethod = ma_smma;   // DMI smoothing method
input int       Smooth      = 0;         // Smothing period (<=1 for no smoothing)
input enMaTypes SmoothType  = ma_ema;    // Smothing method
input double    SignalPeriod = 9;        // Signal period

input int inpFastLength = 3; // Fast length
input int inpSlowLength = 7; // Slow length

//double SellBuffer[];
//double BuyBuffer[];

int MaxBarsExt=1000;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---


   adx_indicator_handle_H1 = iCustom(Symbol(),PERIOD_H1,"Custom_ADX"
                                    );

   iCustom(Symbol(),PERIOD_MN1,"Custom Moving Average_1",8);
   iCustom(Symbol(),PERIOD_MN1,"Custom Moving Average_2",14);
   indicator_customMA_H4_1 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_1",8);
   indicator_customMA_H4_2 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_2",14);
   indicator_customMA_H1_1 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_1",8);
   indicator_customMA_H1_2 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_2",14);
   indicator_customMA_M30_1 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_1",8);
   indicator_customMA_M30_2 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_2",14);
   indicator_customMA_M15_1 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_1",8);
   indicator_customMA_M15_2 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_2",14);
   indicator_customMA_M5_1 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_1",8);
   indicator_customMA_M5_2 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_2",14);


   indicator_handlePivot_MN1 = iCustom(Symbol(),PERIOD_MN1,"pivot",PERIOD_MN1);
   indicator_handlePivot_H1 = iCustom(Symbol(),PERIOD_H1,"pivot",PERIOD_MN1);
   indicator_handlePivot_H4 = iCustom(Symbol(),PERIOD_H4,"pivot",PERIOD_MN1);


   indicator_handlePTL_2_H1 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
   indicator_handlePTL_2_M15 = iCustom(Symbol(),PERIOD_M15,"PTL (2)");
   indicator_handlePTL_2_H4 = iCustom(Symbol(),PERIOD_H4,"PTL (2)");

   indicator_handleSupRes_H4 =iCustom(Symbol(),PERIOD_H4,"Support_and_Resistance");
   indicator_handleSupRes_D1 = iCustom(Symbol(),PERIOD_D1,"Support_and_Resistance");
   indicator_handleSupRes_H1 = iCustom(Symbol(),PERIOD_H1,"Support_and_Resistance");
   indicator_handleSupRes_MN = iCustom(Symbol(),PERIOD_MN1,"Support_and_Resistance");
   indicator_handleSupRes_M5 = iCustom(Symbol(),PERIOD_M5,"Support_and_Resistance");

   indicator_handlePatterns_H4 = iCustom(Symbol(),PERIOD_H4,"patterns_on_chart");
   indicator_handlePatterns_D1 = iCustom(Symbol(),PERIOD_D1,"patterns_on_chart");

   indicator_handlePatterns_M5 = iCustom(Symbol(),PERIOD_M5,"patterns_on_chart");
   indicator_handlePatterns_M15 = iCustom(Symbol(),PERIOD_M15,"patterns_on_chart");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }

MqlRates rates[];

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//if(CheckNewBar() != 1)
//   return;
   double Ask, Bid;
   Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   ArraySetAsSeries(rates,true);
   CopyRates(Symbol(),PERIOD_MN1,0,Bars(Symbol(),PERIOD_MN1),rates);

// ======================= Support && Resistance Zones Work ======================= //

//Support_Resistance_Zones(indicator_handleSupRes);
//Support_Resistance_Zones(indicator_handleSupRes_D1);
//Support_Resistance_Zones(indicator_handleSupRes_MN);
//Support_Resistance_Zones(indicator_handleSupRes_M5);
   double Resi_Zone_M5 = Support_Resistance_Zones_Sell(indicator_handleSupRes_M5,0);
   double Supp_Zone_M5 = Support_Resistance_Zones_Buy(indicator_handleSupRes_M5,0);

   if(Support_Resistance_Area_Check(indicator_handleSupRes_MN,PERIOD_MN1) ==1
      ||
      Support_Resistance_Area_Check(indicator_handleSupRes_D1,PERIOD_D1) ==1 ||
      Support_Resistance_Area_Check(indicator_handleSupRes_H4,PERIOD_H4) ==1
     )
     {

      //Support_Resistance_Area_Check(indicator_handleSupRes_M5,PERIOD_M5) ==1
      ConfluenceTeam[4] = 1;
     }
   else
      if(Support_Resistance_Area_Check(indicator_handleSupRes_MN,PERIOD_MN1) ==0
         ||
         Support_Resistance_Area_Check(indicator_handleSupRes_D1,PERIOD_D1) ==0 ||
         Support_Resistance_Area_Check(indicator_handleSupRes_H4,PERIOD_H4) ==0
        )
        {

         //Support_Resistance_Area_Check(indicator_handleSupRes_M5,PERIOD_M5) ==0
         ConfluenceTeam[4] = 0;
        }
      else
        {
         ConfluenceTeam[4]=-1;
        }


//Comment("BuyBuffer[0]: "+BuyBuffer[12]+" "+"SellBuffer[0]: "+SellBuffer[12]+"\n\n"+
//        "BuyBuffer_D[0]: "+BuyBuffer_D[0]+" "+"SellBuffer_D[0]: "+SellBuffer_D[0]+"\n\n"
//+ "BuyBuffer_MN[0]: "+BuyBuffer_MN[20]+" "+"SellBuffer_MN[0]: "+SellBuffer_MN[20]
//);

//ObjectCreate(0,"4-H",OBJ_HLINE,0,0,BuyBuffer[12]);
//ObjectSetInteger(Symbol(),"4-H",OBJPROP_COLOR,clrGreen);

   for(int i = 0; i<1; i++)
     {
      //ObjectCreate(0,i,OBJ_HLINE,0,0,BuyBuffer_MN[i]);
      //ObjectSetInteger(Symbol(),i,OBJPROP_COLOR,clrRed);
      //ObjectCreate(0,50+i,OBJ_HLINE,0,0,BuyBuffer_D[i]);
      //ObjectSetInteger(Symbol(),50+i,OBJPROP_COLOR,clrGreen);
      //ObjectCreate(0,100+i,OBJ_HLINE,0,0,BuyBuffer[i]);
      //ObjectSetInteger(Symbol(),100+i,OBJPROP_COLOR,clrOrange);
     }


   if(Pivot_Support_Resistance_Area_Check(indicator_handlePivot_H4,PERIOD_H4) == 11)
     {
      ConfluenceTeam[5] = 1;
     }
   else
     {
      ConfluenceTeam[5] = -1;
     }



// =======================  Market Structure Work (Trend Pullback, Range, Retracements) ======================= //
// We could use the ADX indicator and/or MA price action

   if(Market_Structure(adx_indicator_handle_H1) > 0)
     {
      // Means it is trending
      ConfluenceTeam[3] = 1;

     }
   else
     {
      // Means it is ranging/consolidating
      ConfluenceTeam[3] = -1;
     }
   if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_H4) == 1)
     {
      ConfluenceTeam[12] = 0;
     }
   else
      if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_H4) == 0)
        {
         ConfluenceTeam[12] = 1;
        }
      else
        {
         ConfluenceTeam[12] = -1;
        }


// ======================= Moving Average Price Action And MA Crossing ======================= //

   ConfluenceTeam[0] = MA_Cross(indicator_customMA_M5_1, indicator_customMA_M5_2);
   ConfluenceTeam[10] = MA_Cross(indicator_customMA_M15_1, indicator_customMA_M15_2);

   if(MA_PriceAction(indicator_customMA_H4_1, indicator_customMA_H4_2,PERIOD_H4) == 1)
     {
      ConfluenceTeam[2] = 1;
     }
   else
     {
      ConfluenceTeam[2]=0;
     }

   if(MA_PriceAction(indicator_customMA_H1_1, indicator_customMA_H1_2,PERIOD_H1) == 1)
     {
      ConfluenceTeam[8] = 1;
     }
   else
     {
      ConfluenceTeam[8]=0;
     }

   if(MA_PriceAction(indicator_customMA_M30_1, indicator_customMA_M30_2,PERIOD_M30) == 1)
     {
      ConfluenceTeam[9] = 1;
     }
   else
     {
      ConfluenceTeam[9]=0;
     }



// ======================= CandleStickTypes And Patterns ======================= //


// tEST upArrow and downArrow

   if(Patterns_Up(indicator_handlePatterns_M5,1) > 0)
     {
      ConfluenceTeam[1] = 1;
     }
   if(Patterns_Down(indicator_handlePatterns_M5,1) > 0)
     {
      ConfluenceTeam[1] = 0;
     }

   if(Patterns_Up(indicator_handlePatterns_H4,1) > 0)
     {
      ConfluenceTeam[6] = 1;
     }
   if(Patterns_Down(indicator_handlePatterns_H4,1) > 0)
     {
      ConfluenceTeam[6] = 0;
     }
   if(Patterns_Up(indicator_handlePatterns_D1,1) > 0)
     {
      ConfluenceTeam[7] = 1;
     }
   if(Patterns_Down(indicator_handlePatterns_D1,1) > 0)
     {
      ConfluenceTeam[7] = 0;
     }

   if(Patterns_Up(indicator_handlePatterns_M15,1) > 0)
     {
      ConfluenceTeam[11] = 1;
     }
   if(Patterns_Down(indicator_handlePatterns_M15,1) > 0)
     {
      ConfluenceTeam[11] = 0;
     }


   Comment(" Conf[0]:  "+ConfluenceTeam[0]+"\n"
           +" Conf[1]:  "+ConfluenceTeam[1]+"\n"
           + " Conf[2]:  "+ConfluenceTeam[2]+"\n"
           + " Conf[3]:  "+ConfluenceTeam[3]+"\n"
           + " Conf[4]:  "+ConfluenceTeam[4]+"\n"
           + " Conf[5]:  "+ConfluenceTeam[5]+"\n"
           +" Conf[6]:  "+ConfluenceTeam[6]+"\n"
           + " Conf[7]:  "+ConfluenceTeam[7]+"\n"
           + " Conf[8]:  "+ConfluenceTeam[8]+"\n"
           + " Conf[9]:  "+ConfluenceTeam[9]+"\n"
           + " Conf[10]:  "+ConfluenceTeam[10]+"\n"
           +" Conf[11]:  "+ConfluenceTeam[11]+"\n"
           + " Conf[12]:  "+ConfluenceTeam[12]+"\n"
          );
// for(int i=0 ; i< 13; i++)
//{
// Comment("Conf["+i+"]: "+ConfluenceTeam[i]+"\n");
//   }
//Comment("Conf[12]: "+ConfluenceTeam[12]);


// ======================= Entry ======================= //
//if(PositionSelect(Symbol())==false && ConfluenceTeam[0] == 0 && ConfluenceTeam[1] == 0)
//  {
//   trade.Sell(0.01,Symbol(),Bid,Resi_Zone_M5,(Bid - 250*_Point));
//  }
//if(PositionSelect(Symbol())==false && ConfluenceTeam[0]==1 && ConfluenceTeam[1] == 1)
//  {
//   trade.Buy(0.01,Symbol(),Ask,Supp_Zone_M5,(Ask + 250*_Point));
//  }

//  ============================== Possibe CHAIN OF DECISION  ============================== //

   if(ConfluenceTeam[4] != -1 || ConfluenceTeam[5] != -1)
     {
      // Market Structure Trend/Range. Needs to be a trend.
      if(ConfluenceTeam[3] == 1)
        {
         // Buy Confluence: Market Structure using PTL(2) on H4
         if(ConfluenceTeam[12] == 1)
           {
            // Buy Confluence: PatternS using H4 or D1
            if(ConfluenceTeam[6] == 1 || ConfluenceTeam[7] == 1)
              {
               // Buy Confluence: MA Price Action on H1 or M30
               if(ConfluenceTeam[8] ==1 || ConfluenceTeam[9] == 1)
                 {
                  // Buy Confluence: MA Crossover on M15 or M5
                  if((ConfluenceTeam[10] ==1 || ConfluenceTeam[0] == 1) && (ConfluenceTeam[1] == 1 || ConfluenceTeam[11] == 1))
                    {
                     if(PositionSelect(Symbol())==false)
                       {
                        trade.Buy(1,Symbol(),Ask,Supp_Zone_M5,(Ask + 2*MathAbs(Ask - Supp_Zone_M5)));
                       }
                    }
                 }
              }
           }
         // Sell Confluence: Market Structure using PTL(2) on H4
         if(ConfluenceTeam[12] == 0)
           {
            // Sell Confluence: Patterns using H4 or D1
            if(ConfluenceTeam[6] == 0 || ConfluenceTeam[7] == 0)
              {
               // Sell Confluence: Market Structure using MA Price Action on H1 or M30
               if(ConfluenceTeam[8] == 0 || ConfluenceTeam[9] == 0)
                 {
                  // Sell Confluence: MA Crossover on M15 or M5
                  if((ConfluenceTeam[10] == 0 || ConfluenceTeam[0] == 0) && (ConfluenceTeam[1] == 0 || ConfluenceTeam[11] == 0))
                    {
                     if(PositionSelect(Symbol())==false)
                       {
                        trade.Sell(0.01,Symbol(),Bid,Resi_Zone_M5,(Bid - 2*MathAbs(Bid - Resi_Zone_M5)));
                       }
                    }
                 }
              }
           }
        }
     }



  }
//+------------------------------------------------------------------+
int Market_Structure(int indicator_customADX)
  {
//--- indicator buffers
   double    ExtADXBuffer[];
   double    ExtPDIBuffer[];
   double    ExtNDIBuffer[];
   double    ExtPDBuffer[];
   double    ExtNDBuffer[];
   double    ExtTmpBuffer[];

   ArraySetAsSeries(ExtADXBuffer, true);
   ArraySetAsSeries(ExtNDBuffer, true);
   ArraySetAsSeries(ExtPDBuffer, true);
   ArraySetAsSeries(ExtNDIBuffer, true);
   ArraySetAsSeries(ExtPDIBuffer, true);
   ArraySetAsSeries(ExtTmpBuffer, true);

   CopyBuffer(indicator_customADX,0,0,30,ExtADXBuffer);

//Comment("ExtADXBuffer[0]: "+ExtADXBuffer[0]);
   if(ExtADXBuffer[0] > 21)
     {
      return 1;
     }
   else
     {
      return -1;
     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Pivot_Support_Resistance_Area_Check(int indicator_handlePivot_R, ENUM_TIMEFRAMES period)
  {
   int R1_S1_Area_Check;
   int R2_S2_Area_Check;
   int R3_S3_Area_Check;
   int Pivot_Area_Check;
//--- indicator buffers
   double         PivotBuffer[];
   double         R1Buffer[];
   double         R2Buffer[];
   double         R3Buffer[];
   double         S1Buffer[];
   double         S2Buffer[];
   double         S3Buffer[];

   ArraySetAsSeries(PivotBuffer, true);
   ArraySetAsSeries(R1Buffer,true);
   ArraySetAsSeries(R2Buffer,true);
   ArraySetAsSeries(R3Buffer,true);
   ArraySetAsSeries(S1Buffer,true);
   ArraySetAsSeries(S2Buffer,true);
   ArraySetAsSeries(S3Buffer,true);

   CopyBuffer(indicator_handlePivot_R,0,0,50,PivotBuffer);
   CopyBuffer(indicator_handlePivot_R,1,0,50,R1Buffer);
   CopyBuffer(indicator_handlePivot_R,2,0,50,R2Buffer);
   CopyBuffer(indicator_handlePivot_R,3,0,50,R3Buffer);
   CopyBuffer(indicator_handlePivot_R,4,0,50,S1Buffer);
   CopyBuffer(indicator_handlePivot_R,5,0,50,S2Buffer);
   CopyBuffer(indicator_handlePivot_R,6,0,50,S3Buffer);

//Comment("Pivot Buffer[0]: "+PivotBuffer[0] +" VS "+R1Buffer[0] + " VS "+S1Buffer[0] + " VS "+S2Buffer[0]);

   if(Support_Resistance_Area_BluePrint(R1Buffer,S1Buffer,period,500) >= 0)
     {
      return 11;
     }
   else
      if(Support_Resistance_Area_BluePrint(R2Buffer,S2Buffer,period,500) >= 0)
        {
         return 11;
        }
      else
         if(Support_Resistance_Area_BluePrint(R3Buffer,S3Buffer,period,500) >= 0)
           {
            return 11;
           }
         else
           {
            return -11;
           }



  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Support_Resistance_Area_Check(int indicator_handleSupRes_R, ENUM_TIMEFRAMES period)
  {
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);

   double SellBuffer[];
   double BuyBuffer[];
   ArraySetAsSeries(SellBuffer,true);
   ArraySetAsSeries(BuyBuffer, true);

   CopyBuffer(indicator_handleSupRes_R,0,0,50,SellBuffer);
   CopyBuffer(indicator_handleSupRes_R,1,0,50,BuyBuffer);

//Comment("1st: "+ (SellBuffer[0]-300*MathPow(_Point,10)) +"\n"
//        +"2nd: "+ (BuyBuffer[0] + 300*MathPow(_Point,10)));
//Comment(curr_Rates[0].close+" "+BuyBuffer[0]+"\n"+
//"Price: "+MathAbs(curr_Rates[0].close - BuyBuffer[0])+" vs bf: "+MathAbs(curr_Rates[0].close - SellBuffer[0]) );
   if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0]-300*_Point))
     {
      //Print("Resistance Lower");
      // Resistance Zone: Lower Side

      // Check if the support is in the interval also
      if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + 300*_Point) ||
         curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - 300*_Point))
        {
         //Print("Support also");
         if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
           {
            return 0;
           }
         else
           {
            //Print("Support wins.");
            return 1;
           }
        }// if not then continue with the normal response.
      else
        {
         return 0;
        }
      //if(MathAbs(curr_Rates[0].close - BuyBuffer[0]) > MathAbs(curr_Rates[0].close - SellBuffer[0]))
      //  {
      //   return 1;
      //  }
      //else
      //  {
      //   return 0;
      //  }
      //return 0;
     }
   else
      if(curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0]+300*_Point))
        {
         //Print("Resistance Upper");
         // Resistance Zone: Upper Side

         // Check if the support is in the interval also
         if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + 300*_Point) ||
            curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - 300*_Point))
           {
            //Print("Support also");
            if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
              {
               return 0;
              }
            else
              {
               //Print("Support wins.");
               return 1;
              }
           }// if not then continue with the normal response.
         else
           {
            return 0;
           }

        }
      else
         if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + 300*_Point))
           {
            //Print("Support Upper");
            // Support Zone: Upper Side

            // Check if the resistance is in the interval also
            if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0]-300*_Point) ||
               curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0]+300*_Point))
              {
               //Print("Resistance also.");
               if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
                 {
                  //Print("Resistance wins.");
                  return 0;
                 }
               else
                 {
                  return 1;
                 }
              }// if not then continue with the normal response.
            else
              {
               return 1;
              }

           }
         else
            if(curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - 300*_Point))
              {
               //Print("Support Lower");
               // Support Zone: Lower Side

               // Check if the resistance is in the interval also
               if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0]-300*_Point) ||
                  curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0]+300*_Point))
                 {
                  // if it is, then check the closest zone and take its side
                  //Print("Resistance also.");
                  if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
                    {
                     Print("Resistance wins.");
                     return 0;
                    }
                  else
                    {
                     return 1;
                    }
                 }// if not then continue with the normal response.
               else
                 {
                  return 1;
                 }
              }
            else
              {
               return -1;
              }

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Support_Resistance_Area_BluePrint(double &BuyBuffer[], double &SellBuffer[], ENUM_TIMEFRAMES period, int intervalZone)
  {
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);
   if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0]-intervalZone*_Point))
     {
      //Print("Resistance Lower");

      // Resistance Zone: Lower Side

      // Check if the support is in the interval also
      if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + intervalZone*_Point) ||
         curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - intervalZone*_Point))
        {
         //Print("Support also");
         if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
           {
            return 0;
           }
         else
           {
            //Print("Support wins.");
            return 1;
           }
        }// if not then continue with the normal response.
      else
        {
         return 0;
        }
      //if(MathAbs(curr_Rates[0].close - BuyBuffer[0]) > MathAbs(curr_Rates[0].close - SellBuffer[0]))
      //  {
      //   return 1;
      //  }
      //else
      //  {
      //   return 0;
      //  }
      //return 0;
     }
   else
      if(curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0] + intervalZone*_Point))
        {
         //Print("Resistance Upper");
         // Resistance Zone: Upper Side

         // Check if the support is in the interval also
         if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + intervalZone*_Point) ||
            curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - intervalZone*_Point))
           {
            //Print("Support also");
            if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
              {
               return 0;
              }
            else
              {
               //Print("Support wins.");
               return 1;
              }
           }// if not then continue with the normal response.
         else
           {
            return 0;
           }

        }
      else
         if(curr_Rates[0].close >= SellBuffer[0] && curr_Rates[0].close <= (SellBuffer[0] + intervalZone*_Point))
           {
            //Print("Support Upper");
            // Support Zone: Upper Side

            // Check if the resistance is in the interval also
            if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0]-intervalZone*_Point) ||
               curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0]+intervalZone*_Point))
              {
               //Print("Resistance also.");
               if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
                 {
                  //Print("Resistance wins.");
                  return 0;
                 }
               else
                 {
                  return 1;
                 }
              }// if not then continue with the normal response.
            else
              {
               return 1;
              }

           }
         else
            if(curr_Rates[0].close <= SellBuffer[0] && curr_Rates[0].close >= (SellBuffer[0] - intervalZone*_Point))
              {
               //Print("Support Lower");
               // Support Zone: Lower Side

               // Check if the resistance is in the interval also
               if(curr_Rates[0].close <= BuyBuffer[0] && curr_Rates[0].close >= (BuyBuffer[0] - intervalZone*_Point) ||
                  curr_Rates[0].close >= BuyBuffer[0] && curr_Rates[0].close <= (BuyBuffer[0] + intervalZone*_Point))
                 {
                  // if it is, then check the closest zone and take its side
                  //Print("Resistance also.");
                  if(MathAbs(curr_Rates[0].close - SellBuffer[0]) > MathAbs(curr_Rates[0].close - BuyBuffer[0]))
                    {
                     Print("Resistance wins.");
                     return 0;
                    }
                  else
                    {
                     return 1;
                    }
                 }// if not then continue with the normal response.
               else
                 {
                  return 1;
                 }
              }
            else
              {
               return -1;
              }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support_Resistance_Zones_Buy(int indicator_handleSupRes_R, int index)
  {
   double SellBuffer[];
   ArraySetAsSeries(SellBuffer, true);


   CopyBuffer(indicator_handleSupRes_R,0,0,50,SellBuffer);

   return SellBuffer[index];

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support_Resistance_Zones_Sell(int indicator_handleSupRes_R, int index)
  {

   double BuyBuffer[];

   ArraySetAsSeries(BuyBuffer,true);


   CopyBuffer(indicator_handleSupRes_R,1,0,50,BuyBuffer);
   return BuyBuffer[index];

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int MA_Cross(int indicator_customMA_1, int indicator_customMA_2)
  {
   double myMovingAverageArray_lowPer[];
   double myMovingAverageArray_highPer[];
   int crossedStatus = -1;;


   ArraySetAsSeries(myMovingAverageArray_lowPer, true);
   ArraySetAsSeries(myMovingAverageArray_highPer, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer);

// Crossover bwteen 8-P and 14-P.
   if(myMovingAverageArray_lowPer[1]>myMovingAverageArray_highPer[1]
      && myMovingAverageArray_lowPer[2]<myMovingAverageArray_highPer[2])
     {
      crossedStatus = 1;
      //Print("Crossed Up Up");


      return crossedStatus;

     }
   else

      //   Crossover bwteen 8-P and 14-P.
      if(myMovingAverageArray_lowPer[1]<myMovingAverageArray_highPer[1]
         && myMovingAverageArray_lowPer[2]>myMovingAverageArray_highPer[2])
        {
         crossedStatus = 0;
         //Print("Crossed Down Down");

         return crossedStatus;

        }
      else
        {
         crossedStatus = -1;
         return crossedStatus;
        }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int MA_PriceAction(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period)
  {
// This is made for Higher Timeframes.
   double myMovingAverageArray_lowPer[];
   double myMovingAverageArray_highPer[];
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);

   ArraySetAsSeries(myMovingAverageArray_lowPer, true);
   ArraySetAsSeries(myMovingAverageArray_highPer, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer);

   if(curr_Rates[1].close < myMovingAverageArray_lowPer[1] && curr_Rates[2].close < myMovingAverageArray_lowPer[2])
     {
      return 0;
     }
   else
     {
      return 1;
     }



  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Patterns_Up(int indicator_handlePatterns_R, int index)
  {
   double upArrow[];
   ArraySetAsSeries(upArrow,true);


   CopyBuffer(indicator_handlePatterns_R,0,0,50,upArrow);


   return upArrow[index];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Patterns_Down(int indicator_handlePatterns_R, int index)
  {

   double downArrow[];

   ArraySetAsSeries(downArrow,true);


   CopyBuffer(indicator_handlePatterns_R,1,0,50,downArrow);
   return downArrow[index];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TrendLine_MarketStructure_PTL(int indicator_PTL_R)
  {
   double slowlu[],slowln[],fastln[],arrowar[],arrowcl[],candleo[],candleh[],candlel[],candlec[],candleC[];

   ArraySetAsSeries(candleC,true);
   CopyBuffer(indicator_PTL_R,4,0,50,candleC);

   if(candleC[1] == 1)
     {
      return 1;
     }
   else
      if(candleC[1] == 0)
        {
         return 0;
        }
      else
        {
         return -1;
        }
//Comment("candleC[1]: "+candleC[1]);
  }


int DailyConfluenceTeam[15];
int ConfluenceTeam[20];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void getPointsGeneral(double candPatternSignal, int movingAverageSignal, double trendSignalBelow,
                      double trendSignalAbove,double trendSignalBelow_2,
                      double trendSignalAbove_2, double &limitUpperDoncInd[],double &limitLowerDoncInd[],
                      int bullCandleSignal, int bearCandleSignal, int candStickTypeSignal, int BreakOfStructureSignal,double zoneEnterSignal,
                      double &suppResPrice[], double &suppResPrice_2[], int goldenMACandleSignal,
                      int goldenMASignalCrossing, int candleIndecisionSignal, int consolidationSignal,

                      int movingAverageSignal_Daily, double trendSignalBelow_Daily,
                      double trendSignalAbove_Daily,double trendSignalBelow_Daily_2,
                      double trendSignalAbove_Daily_2, int bullCandleSignal_Daily, int bearCandleSignal_Daily,
                      int candStickTypeSignal_Daily, int BreakOfStructureSignal_Daily,int goldenMACandleSignal_Daily,
                      int goldenMASignalCrossing_Daily)
  {



  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckNewBar()
  {
   MqlRates      current_rates[1];
   CopyRates(Symbol(),PERIOD_CURRENT,0,1,current_rates);
   double current_volume = (const)current_rates[0].tick_volume;

   ResetLastError();
   if(CopyRates(Symbol(),PERIOD_CURRENT,0,1,current_rates)!=1)
     {
      //Print("CopyRates copy error, Code = ",GetLastError());
      return(0);
     }

// Only consider updating the OnTick() when the current rate's volume is greater than 50.
//   if(current_volume > 50)
//     {
//      if(current_rates[0].tick_volume>(current_volume + 50))
//        {
//         return(0);
//        }
//     }
//   else
//     {
//
//     }
   if(current_rates[0].tick_volume>1)
     {
      return(0);
     }



   return(1);
  }
//+------------------------------------------------------------------+
